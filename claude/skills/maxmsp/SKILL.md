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

## Showing/Hiding Objects at Runtime

- `"hidden": 1` makes an object invisible in presentation (set in JSON or toggled at runtime)
- Send `hidden 0` or `hidden 1` messages to show/hide dynamically
- For bpatchers, use `thispatcher` with `script sendbox <varname> hidden $1` to show/hide by varname
- Multiple objects can share the same `presentation_rect` — toggle `hidden` to swap which is visible

## Common Objects

### panel (Background Rectangles)
- **`live.panel` does not exist** — use `panel` (maxclass `"panel"`) with `"mode": 0`
- `"bgcolor": [ r, g, b, a ]` (0.0–1.0 floats)
- `"rounded": 4` for corner rounding

### comment (Static Labels)
- `"textcolor": [ r, g, b, a ]` for custom text color
- `"fontname"` and `"fontsize"` for typography

### bpatcher (Embedded Sub-patches)
- `"name": "filename.maxpat"` sets the loaded patch file
- The bpatcher's `presentation_rect` defines the viewport
- Key properties for seamless embedding:
  ```json
  "bgmode": 0, "border": 0, "clickthrough": 0,
  "enablehscroll": 0, "enablevscroll": 0,
  "lockeddragscroll": 0, "lockedsize": 0,
  "offset": [0.0, 0.0], "viewvisibility": 1
  ```

### ubutton (Invisible Click Target)
- Transparent, invisible button — set `hltcolor` with alpha 0.0
- Outputs: bang (down), bang (up), position, int (toggle)
- Used to overlay visual elements that need click behavior

### Visual Display Objects
- **`spectroscope~`** — frequency analyzer (`logfreq`, `domain`, `fgcolor`, `markercolor`, `bgcolor`)
- **`waveform~`** — audio waveform display (`buffername` links to a `buffer~`)
- **`filtergraph~`** — interactive filter frequency response curve
- **`lcd`** — drawing canvas, can be transparent overlay with `bgtransparent: 1`, `border: 0`

## Conventions

- Preserve existing object IDs when editing to avoid breaking connections
- Keep signal flow left-to-right or top-to-bottom
- Group related functionality into `bpatcher` or `p` (subpatcher) objects

## When Editing .maxpat JSON

- Always read the file first to understand the existing patch structure
- Validate JSON after edits
- Do not reorder or renumber objects unnecessarily
- Preserve formatting style of the existing file

