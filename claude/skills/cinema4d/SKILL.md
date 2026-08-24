---
name: cinema4d
description: Render Cinema 4D scenes headlessly with the `rk-c4d-render` script. Use when creating or editing a Cinema 4D scene script (a `.py` driving `c4d`), or when asked to render a Cinema 4D scene.
allowed-tools: Read, Write, Edit, Grep, Glob, Bash
---

# Cinema 4D

Scenes are built as standalone Python scripts that construct everything from an
empty document, then rendered headlessly. Never rely on a saved `.c4d` as the
source of truth — the `.py` is. Each render writes a `.c4d` beside the image,
as a by-product for opening in the GUI, not as an input.

## Rendering

Always render with `rk-c4d-render`, never by invoking the Cinema 4D binary
directly:

```sh
rk-c4d-render scene.py              # -> ./renders/<name>-<epoch>.png
rk-c4d-render scene.py --preview    # 800x600, cheap sampling, sets ctx.preview
rk-c4d-render scene.py -w 64 --height 48
```

Full renders default to 1600x1200. Other flags: `-o/--output-dir` (default
`renders`), `-v/--verbose` to echo all of Cinema 4D's console output rather than
just progress, `--c4d` / `C4D_BIN` for the binary, `--loader-dir` /
`C4D_LOADER_DIR` for the loader folder.

The script is on `PATH` (source:
`~/Developer/Dotfiles/install/scripts/bin/rk-c4d-render.py`). It writes into
`./renders` relative to the current working directory — `cd` to the project
directory before rendering. Every run also writes `./renders/render.log` holding
Cinema 4D's full output; on failure the script prints the Python traceback out
of it, and the log is where to look for anything else.

Do not reach for `c4dpy`. It needs separate licensing behind an interactive
prompt, and it spins at 100% CPU on EOF from a closed stdin. `rk-c4d-render`
uses `Cinema 4D -nogui` with a startup plugin instead.

## Scene Script Contract

`rk-c4d-render` sets `g_additionalModulePath` so Cinema 4D loads
`c4d_loader.pyp` at startup, which imports the scene module and hands it to
`scene_runner.py`
(`~/Developer/Settings/Apps/Cinema 4D/c4d_loader/scene_runner.py`). A scene
module must define:

```python
def build(doc, ctx):
    """Populate `doc`; return the camera to render through, or None."""
```

and may define:

```python
def configure_render(rd, ctx):
    """Adjust the render data after the defaults, before sampling is applied."""
```

`ctx` carries `scene_path`, `output_dir`, `width`, `height`, `preview`,
`timestamp`, and `name`. Resolve any asset path relative to `ctx.scene_path`,
never to the working directory. Branch on `ctx.preview` to skip expensive setup
during iteration.

The runner owns resolution, aspect, output paths, timestamping, saving, and
per-engine sampling. Do not set `RDATA_XRES`/`RDATA_YRES` or Cinema 4D's own
image saving in a scene; do not render or name files yourself.

## Renderer

Redshift is the default, set by the runner. It renders on the GPU and licenses
headlessly with no prompt. A scene that wants a different engine sets
`RDATA_RENDERENGINE` in `configure_render`, and the runner then applies that
engine's sampling — Standard's `RDATA_AA*` levels, or Redshift's unified
samples on its `VPrsrenderer` video post. Other engines keep their own defaults.

Build Redshift scenes out of Redshift's own materials and lights. Cinema 4D
will silently convert Standard materials, but the conversion loses refraction
detail and flattens tonality.

Redshift is not always faster. On a simple scene it can lose to Standard on
wall clock while using a fraction of the CPU.

## Redshift Materials

Redshift materials are node graphs in their own node space, reached through the
`maxon` API. Every node and port id is prefixed
`com.redshift3d.redshift4c4d.nodes.core.`:

```python
rs_space = maxon.NodeSpaceIdentifiers.RedshiftMaterial
rs = "com.redshift3d.redshift4c4d.nodes.core."

mat = c4d.BaseMaterial(c4d.Mmaterial)   # Mmaterial, not Mrsgraph
node_mat = mat.GetNodeMaterialReference()
node_mat.CreateDefaultGraph(rs_space)
graph = node_mat.GetGraph(rs_space)
```

`CreateDefaultGraph` asserts on anything but `c4d.Mmaterial`. It builds a
`standardmaterial` node wired to the output; find it by walking
`graph.GetViewRoot().GetChildren()` and matching `"standardmaterial"` in
`str(child.GetId())`.

Every mutation goes inside a transaction:

```python
with graph.BeginTransaction() as transaction:
    port.SetPortValue(value)
    transaction.Commit()
```

Look ports up by full id and check `IsNullValue()`. Some are bundles whose
leaves are children — a texture path is `path` under the `tex0` bundle, and
its value must be a `maxon.Url`:

```python
tex0 = port(sampler, rs + "texturesampler.tex0")
tex0.FindChild("path").SetPortValue(maxon.Url(path))
```

Not everything is settable from Python. `REDSHIFT_LIGHT_DOME_TEX0` rejects both
`str` and `Url` — to get a textured environment, use an emissive sphere
enclosing the scene and a plain untextured dome light for fill.

Glass is `refr_weight` 1.0, `refr_roughness` 0.0, `refl_weight` 1.0, `refl_ior`
1.52, `base_color_weight` 0.0, `refr_thin_walled` False. Raise `refr_depth` to
16 and `refl_depth` to 8; the defaults cut off before the far side of a solid
sphere. Set `shadow_opacity` to 0.0 so glass transmits shadow rays.

## Color

Redshift decodes textures from sRGB to linear on load, so authored texture
values are not the values that render. A `128` grey arrives as linear `0.22` and
crushes to near-black. Author around linear `0.5` as sRGB `190`.

## Tessellation

Redshift tessellates Cinema 4D primitives, so `PRIM_SPHERE_PERFECT` —
Standard's analytic sphere — does nothing. Faceting shows up as blocky
refraction. Add a `Tphong` tag and raise the subdivision:

```python
tag = obj.MakeTag(c4d.Tphong)
tag[c4d.PHONGTAG_PHONG_ANGLELIMIT] = False
sphere[c4d.PRIM_SPHERE_SUB] = 256
```

A ball lens magnifies its own tessellation, so refractive spheres need far more
subdivision than their size suggests.

## Enclose the Scene

A glass sphere inverts what it refracts, so its lower half shows whatever is
above the horizon. With nothing there it renders as a black band that reads
convincingly like a shadow or a backface bug. Enclose the scene in a sky sphere.
Rotate it 90° so its UV seam faces away from the camera, or the glass magnifies
the seam into a hard line.

## Gotchas

- `c4d.utils.VectorToHPB(direction)` aims an object; there is no
  `HPBFromVector`.
- `BaseDraw` has `SetSceneCamera` only; there is no `SetEditorCamera`.
- Global illumination costs minutes and washes out contrast on a simple scene.
  `VPambientocclusion` gives most of the contact shading for a fraction of it.
- Cinema 4D always exits 0. The runner writes a status file, which is why the
  exit code from `rk-c4d-render` is meaningful.

## Iterating

Render with `--preview` while composing, then at full size for the final
image. Always look at the result — read the PNG back — rather than assuming
the scene matches the intent. Framing, texture scale, and blown-out lighting
are only visible in the image, and a wrong material reads as a lighting bug.
