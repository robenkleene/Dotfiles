---
name: blender
description: Render Blender scenes headlessly with the `rk-blender-render` script. Use when creating or editing a Blender scene script (a `.py` driving `bpy`), or when asked to render a Blender scene.
allowed-tools: Read, Write, Edit, Grep, Glob, Bash
---

# Blender

Scenes are built as standalone Python scripts that construct everything from an
empty file, then rendered headlessly. Never rely on a saved `.blend` as the
source of truth — the `.py` is.

## Rendering

Always render with `rk-blender-render`, never by invoking `blender` directly:

```sh
rk-blender-render scene.py                 # -> ./renders/<name>-<epoch>.png
rk-blender-render scene.py --samples 512   # extra args go to the scene script
```

Every render is archived with the scene that produced it: the script saves a
matching `./renders/<name>-<epoch>.blend` next to the image, so any render can
be reopened and inspected. It derives that path from
`scene.render.filepath`, which is another reason a scene script must set a
complete output path including the extension. The save is skipped when no
render landed on disk, so a scene script that fails leaves no stray `.blend`.

The script is on `PATH` (source:
`~/Developer/Dotfiles/install/scripts/bin/rk-blender-render.sh`). It passes
`--background --factory-startup`, so no user Blender config is read or written,
and it writes into `./renders` relative to the current working directory — `cd`
to the project directory before rendering.

Exit codes: `64` on no arguments, `66` when the scene file does not exist.

## Scene Script Contract

`rk-blender-render` calls `blender --python scene.py -- --output <abs-dir>`, so
a scene script must:

1. Parse its arguments from after the `--` separator, since everything before
   it belongs to Blender:

   ```python
   def parse_args(argv):
       argv = argv[argv.index("--") + 1 :] if "--" in argv else []
       parser = argparse.ArgumentParser()
       parser.add_argument("--output", default=os.path.join(os.getcwd(), "renders"))
       parser.add_argument("--name", default="scene")
       parser.add_argument("--samples", type=int, default=256)
       return parser.parse_args(argv)
   ```

2. Accept `--output DIR` and write its render there. Default it to
   `./renders` so running under plain `blender` behaves the same.

3. Name output `<name>-<unix-epoch>.<ext>` so renders sort by render time and
   never overwrite each other:

   ```python
   extension = bpy.context.scene.render.image_settings.file_format.lower()
   filepath = os.path.join(args.output, f"{args.name}-{int(time.time())}.{extension}")
   bpy.context.scene.render.filepath = filepath
   bpy.ops.render.render(write_still=True)
   ```

4. Start from an empty scene, not the default cube:

   ```python
   bpy.ops.wm.read_factory_settings(use_empty=True)
   ```

Expose the knobs worth iterating on as arguments (`--samples`, `--resolution`,
`--device`) rather than editing the file for each test render.

## Cycles

Use Cycles, not Eevee. Eevee only approximates refraction and global
illumination, so glass and caustics look wrong.

```python
scene.render.engine = "CYCLES"
scene.cycles.samples = args.samples
scene.cycles.use_denoising = True
```

Select the GPU by setting the Cycles addon preferences, then the scene device;
setting `scene.cycles.device = "GPU"` alone silently falls back to CPU. On this
machine the backend is `METAL`. Assigning an unsupported
`compute_device_type` raises `TypeError`, so probe in a `try`/`except` and fall
back to CPU when no non-CPU device is found.

```python
preferences = bpy.context.preferences.addons["cycles"].preferences
preferences.compute_device_type = "METAL"
preferences.get_devices()
for device in preferences.devices:
    device.use = True
scene.cycles.device = "GPU"
```

Transmissive materials need the bounce limits raised — the defaults clip glass
to a dark core:

```python
scene.cycles.max_bounces = 24
scene.cycles.transmission_bounces = 24
scene.cycles.transparent_max_bounces = 24
scene.cycles.caustics_refractive = True
```

## Materials

Principled BSDF socket names changed in Blender 4.0 (`Transmission` ->
`Transmission Weight`, `Specular` -> `Specular IOR Level`, `Emission` ->
`Emission Color`). Look sockets up by name and tolerate a miss rather than
indexing by position:

```python
def set_input(node, names, value):
    for name in names:
        socket = node.inputs.get(name)
        if socket is not None:
            socket.default_value = value
            return True
    return False

set_input(bsdf, ("Transmission Weight", "Transmission"), 1.0)
```

Glass is transmission `1.0`, roughness `0.0`, IOR `1.45`, metallic `0.0`.

`use_nodes = True` on `Material` and `World` is deprecated as of Blender 5.1
and warns on every run; it still works and is currently the way to get a node
tree.

## Texture Coordinates

A Checker Texture driven by `Object` coordinates scales in the object's local
units, so a plane created with `size=40` spans -20..20 and `Scale` means
squares per unit — `0.5` gives 20 squares across, while the default `5.0` gives
a moiré-fine grid. Check the scale in a low-sample render before committing.

## Iterating

Render at low samples (`--samples 32`) while composing the scene, then re-render
at the default for the final image. Always look at the result — read the PNG
back — rather than assuming the scene matches the intent. Framing, texture
scale, and blown-out lighting are only visible in the image.
