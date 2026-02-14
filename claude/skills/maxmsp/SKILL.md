---
name: maxmsp
description: Work with Max/MSP .maxpat files. Use when editing, analyzing, or creating Max patches.
allowed-tools: Read, Write, Edit, Grep, Glob
---

# Max/MSP Patching

## .maxpat File Format

- `.maxpat` files are JSON documents
- Top-level key is `patcher`, containing `boxes` (objects) and `lines` (connections)
- Each box has a `maxclass` (e.g., `newobj`, `message`, `comment`, `bpatcher`), a `patching_rect` for position/size, and class-specific attributes
- Lines connect outlets to inlets via `source` and `destination` arrays: `[object_id, outlet_index]`

## Z-Order (Critical)

- In the `boxes` array, objects listed **first** render **on top** in presentation mode
- Objects listed **last** render **behind** everything else
- Background panels must go at the **end** of the array, or they will cover all controls

## Presentation Mode

- Set `openinpresentation: 1` on the patcher to enable presentation view
- Each object visible in presentation needs both:
  - `"presentation": 1`
  - `"presentation_rect": [ x, y, width, height ]`
- Objects always need `patching_rect` too (for the patching/edit view)
- `presentation_rect` controls position in the user-facing UI; `patching_rect` controls position in the wiring view

## Showing/Hiding Objects at Runtime

- `"hidden": 1` makes an object invisible in presentation mode (set in JSON or toggled at runtime)
- Send `hidden 0` or `hidden 1` messages to show/hide objects dynamically
- For bpatchers, use `thispatcher` with `script sendbox <varname> hidden $1` to show/hide by varname
- Multiple objects can share the same `presentation_rect` — toggle `hidden` to swap which is visible
- This is the standard pattern for view switching and multi-state icon displays

## Common Object Pitfalls

- **`live.panel` does not exist** — use `panel` (maxclass `"panel"`) with `"mode": 0` for a filled rectangle background
- Panel bgcolor is set with `"bgcolor": [ r, g, b, a ]` (0.0–1.0 floats)
- If no `bgcolor` is specified, panels use the default theme color

## live.* Parameter Objects

Objects like `live.dial`, `live.tab`, `live.text`, `live.numbox` require:

```json
{
    "parameter_enable": 1,
    "saved_attribute_attributes": {
        "valueof": {
            "parameter_longname": "UniqueParamName",
            "parameter_shortname": "Display",
            "parameter_type": 0,
            "parameter_modmode": 0
        }
    },
    "varname": "UniqueParamName"
}
```

Parameter types:
- `0` = float (for dials, sliders)
- `2` = enum/int (for tabs, toggles, menus)
- `4` = blob (for live.drop)

Key valueof fields:
- `parameter_mmax` / `parameter_mmin` — value range
- `parameter_enum` — list of enum labels (for type 2)
- `parameter_unitstyle` — display units (1=float, 2=ms, 4=dB, 9=custom)
- `parameter_exponent` — curve exponent for non-linear scaling (e.g., 3.0 for time dials)
- `parameter_invisible: 2` — hides from automation view but keeps parameter functional
- `parameter_linknames: 1` — links varname to parameter longname automatically
- `parameter_initial` / `parameter_initial_enable` — set default value on load

## ubutton (Invisible Click Target)

- `maxclass: "ubutton"` — a transparent, invisible button
- Set `hltcolor` with alpha 0.0 to make it fully invisible
- Outputs: bang (down), bang (up), position, int (toggle)
- Can have `parameter_enable: 1` to store state
- Used to overlay visual elements (like SVG icons) that need click behavior

## live.text (Toggle/Momentary Buttons)

- `"mode": 0` makes it momentary (bang on click), omit or set to 1 for toggle
- `"text"` = label when off, `"texton"` = label when on
- Can display SVG icons: `"pictures": ["off.svg", "on.svg"]`, `"usepicture": 1`, `"usesvgviewbox": 1`
- `"remapsvgcolors": 1` — lets SVG inherit theme colors (essential for theming)
- `"ignoreclick": 1` — makes it display-only (pair with a `ubutton` overlay for interaction)

## live.tab (Tab Selectors)

- `"num_lines_patching"` / `"num_lines_presentation"` control orientation:
  - 1 line = horizontal tabs
  - Multiple lines = vertical tabs (one per line)
- Tab labels set via `parameter_enum` array
- Outputs selected index from first outlet

## live.line (Dividers)

- Thin separator lines between UI sections
- Use in presentation mode to visually divide functional areas

## live.adsrui (Envelope Editor)

- Graphical ADSR envelope editor with draggable handles
- Key properties: `curvecolor`, `sustaincolor` for theme colors
- `enable_final: 0`, `enable_initial: 0`, `enable_peak: 0` to simplify to basic ADSR

## live.comment vs comment

- `live.comment` — dynamic text, can be updated at runtime via messages
- `comment` — static labels, set once in the patch

## bpatcher

- Use for embedding sub-patches with their own presentation view
- `"name": "filename.maxpat"` sets the loaded patch file
- The bpatcher's `presentation_rect` defines the viewport; the loaded patch fills it
- Key properties for seamless embedding:
  ```json
  "bgmode": 0, "border": 0, "clickthrough": 0,
  "enablehscroll": 0, "enablevscroll": 0,
  "lockeddragscroll": 0, "lockedsize": 0,
  "offset": [0.0, 0.0], "viewvisibility": 1
  ```

## Visual Display Objects

- **`spectroscope~`** — frequency spectrum analyzer
  - Key properties: `logfreq`, `domain` (freq range), `range`, `fgcolor`, `markercolor`, `bgcolor`
- **`waveform~`** — audio waveform display with interactive selection
  - Key property: `buffername` to link to a `buffer~` object
- **`live.drop`** — drag-and-drop zone for audio files
  - Key properties: `decodemode`, `legend` (placeholder text)
  - Often overlaid on `waveform~` at the same position
- **`filtergraph~`** — interactive filter frequency response curve
- **`lcd`** — drawing canvas, can be transparent overlay with `bgtransparent: 1`, `border: 0`

## Theme Color Expressions

Colors can reference the Live theme instead of being hardcoded:

```json
"saved_attribute_attributes": {
    "bgfillcolor": {
        "expression": "themecolor.live_lcd_bg"
    }
}
```

Common theme colors:
- `live_lcd_bg` — dark panel/LCD background
- `live_surface_bg` — device surface/control group background
- `live_control_fg` — general control foreground
- `live_value_arc` — accent color (cyan dial arcs, active values)
- `live_active_automation` — automation indicator
- `live_lcd_control_fg` — text on dark backgrounds
- `live_lcd_control_fg_zombie` — dimmed/secondary text on dark backgrounds
- `live_control_fg_off` / `live_control_fg_off_zombie` — inactive control states
- `live_lcd_frame` — borders on dark backgrounds
- `live_macro_title` — title/header bar backgrounds
- `live_output_curve_color` — waveform display color
- `live_control_selection` — selection highlight

## Conventions

- Preserve existing object IDs when editing to avoid breaking connections
- Keep signal flow left-to-right or top-to-bottom
- Use `comment` objects to document non-obvious logic
- Group related functionality into `bpatcher` or `p` (subpatcher) objects

## When Editing .maxpat JSON

- Always read the file first to understand the existing patch structure
- Validate JSON after edits
- Do not reorder or renumber objects unnecessarily
- Preserve formatting style of the existing file

## Patcher-Level Parameters Block

The patcher can have a top-level `"parameters"` object that registers all parameter objects:

```json
"parameters": {
    "obj-id": [ "LongName", "ShortName", defaultValue ],
    "inherited_shortname": 1
}
```
