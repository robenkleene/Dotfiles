---
name: maxmsp-m4l
description: Build Max for Live devices. Use when working with .amxd files or .maxpat files containing live.* objects, including theming and device UI design.
allowed-tools: Read, Write, Edit, Grep, Glob
---

# Max for Live

## live.* Parameter Objects

Objects like `live.dial`, `live.tab`, `live.text`, `live.numbox`, `live.menu` require:

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

Parameter types: `0` = float, `2` = enum/int, `4` = blob (live.drop)

**Important**: `parameter_longname` must be unique across the entire device — duplicates cause silent parameter conflicts.

Key valueof fields:
- `parameter_mmax` / `parameter_mmin` — value range
- `parameter_enum` — list of enum labels (for type 2)
- `parameter_unitstyle` — display units (1=float, 2=ms, 4=dB, 9=custom)
- `parameter_exponent` — curve exponent for non-linear scaling (e.g., 3.0 for time dials)
- `parameter_invisible: 2` — hides from automation view but keeps parameter functional
- `parameter_linknames: 1` — links varname to parameter longname
- `parameter_initial` / `parameter_initial_enable` — set default value on load

## live.* Object Reference

### live.dial
- The dominant control type across Ableton devices
- Size: ~50x48px with label
- `parameter_exponent: 3.0` for time-based parameters (attack, decay)

### live.text (Toggle/Momentary)
- `mode: 0` for momentary (bang), omit for toggle
- `text` = off label, `texton` = on label
- SVG icons: `pictures: ["off.svg", "on.svg"]`, `usepicture: 1`, `usesvgviewbox: 1`
- `remapsvgcolors: 1` — SVGs inherit theme colors (essential for theming)
- `ignoreclick: 1` — display-only (pair with `ubutton` overlay for interaction)
- **`appearance: 2`** — bordered button style. Gives an orange-bordered look automatically via the theme, with no custom color properties needed. Use for toggle/momentary buttons on dark LCD backgrounds. Title case text (e.g., "Audio", "Sample"), typical size ~59x15px. Reference: Surround Panner's "Share Setup" button.

### live.tab
- `num_lines_presentation: 1` = horizontal, `N` = vertical (one tab per line)
- Labels via `parameter_enum` array

### live.menu
- Dropdown selector with small triangle indicator

### live.numbox
- `lcdbgcolor` with transparent alpha for floating-on-panel look
- `lcdcolor` with `themecolor.live_value_arc` for accent color

### live.line
- Thin separator line between UI sections

### live.comment vs comment
- `live.comment` — dynamic text, updateable at runtime
- `comment` — static labels

### live.adsrui
- Graphical ADSR envelope editor with draggable handles
- `curvecolor`, `sustaincolor` for theme colors
- `enable_final: 0`, `enable_initial: 0`, `enable_peak: 0` to simplify to basic ADSR

### live.drop
- Drag-and-drop zone for audio files
- `decodemode`, `legend` (placeholder text)
- Often overlaid on `waveform~` at the same position

## Theme Color System

Colors reference the Live theme instead of being hardcoded, via `saved_attribute_attributes`:

```json
"saved_attribute_attributes": {
    "bgfillcolor": {
        "expression": "themecolor.live_lcd_bg"
    }
}
```

### Panel/Background Colors
- `live_lcd_bg` — dark panel/LCD background (for visual/content areas)
- `live_surface_bg` — control group panel background (Device Inspector: `Live Theme Colors: Device Background`)
- Device background panel should use Device Inspector: `Live Theme Colors: Control Header`

### Control Colors
- `live_value_arc` — primary accent (cyan dial arcs, active values, active view icons)
- `live_active_automation` — automation indicator (orange/amber)
- `live_control_fg` — general control foreground
- `live_control_fg_off` — inactive control foreground
- `live_lcd_control_fg` — text/controls on dark backgrounds
- `live_lcd_frame` — borders on dark backgrounds
- `live_output_curve_color` — waveform display color
- `live_control_selection` — selection highlight

### Dimmed/Zombie Variants
- `_zombie` suffix = dimmed/inactive variant (e.g., `live_lcd_control_fg_zombie` for secondary labels)
- `_off_zombie` = doubly dimmed

### Where to Apply
- `bgfillcolor` — panel backgrounds
- `textcolor`, `activetextcolor`, `activetextoncolor` — text states
- `bordercolor`, `focusbordercolor` — borders
- `lcdcolor`, `lcdbgcolor` — numbox colors
- `curvecolor`, `sustaincolor` — envelope editors

## Patcher-Level Parameters Block

The patcher can have a top-level `"parameters"` object that registers all `live.*` parameter objects:

```json
"parameters": {
    "obj-id": [ "LongName", "ShortName", defaultValue ],
    "inherited_shortname": 1
}
```

## SVG Icon Pattern

For multi-state visual indicators (mode icons, filter type, view toggles):

1. Multiple `live.text` objects at the **same `presentation_rect`**, each with a different SVG
2. All set to `hidden: 1` and `ignoreclick: 1` except the active one
3. `remapsvgcolors: 1` so SVGs adapt to theme
4. Overlay a transparent `ubutton` for click handling
5. Logic toggles `hidden` to show the correct icon

## View Switching (Tab-like Behavior)

The correct pattern for switching between views uses **`ubutton` + `live.text` icons + `hidden` toggling**, not `live.tab`:

### Architecture (as used in Granulator III)
1. **Visual indicator**: `live.text` with SVG icon (`ignoreclick: 1`) — display-only
2. **Click target**: `ubutton` (transparent) overlaid on the icon — handles clicks, stores state
3. **View content**: Multiple `bpatcher` objects at the **same `presentation_rect`**
4. **Switching**: ubutton → logic → `thispatcher` receives `script sendbox <varname> hidden $1`

### Why not `live.tab`?
`live.tab` doesn't integrate with the dark-panel visual style. The ubutton + icon pattern gives full control — icons on dark backgrounds, theme-colored active states, seamless panel integration.

### Key details
- Active icon: `activetextoncolor` → `themecolor.live_value_arc` (cyan)
- Inactive icon: `activetextcolor` → gray
- All backgrounds transparent (alpha 0.0) so icons float on the dark panel
- `parameter_invisible: 2` on the ubutton (hidden from automation)

---

# Device UI Design

## M4L vs Native Design

Max for Live devices cannot exactly replicate native Ableton device designs. Native devices (Simpler, Hybrid Reverb, etc.) use proprietary UI elements and fonts not available in Max. When designing M4L devices:

- **Don't copy native button styles**: Native devices use all-caps text with a proprietary blocky font for toggle buttons (e.g., Simpler's LOOP/SNAP). This is impossible to replicate in Max. Instead, use `live.text` with `appearance: 2` for bordered toggle buttons — this gives the standard M4L orange-bordered style with full theme support.
- **Use M4L devices as design references**: Reference other Max for Live devices (Surround Panner, Granulator III) rather than native Ableton devices for UI patterns. M4L devices demonstrate what's actually achievable with Max UI objects.

## Device Constraints

- M4L devices display in Live's device chain with a fixed height and variable width
- Drawable device height is **169px** in Max coordinates (338px on macOS Retina / 2)
- New Max for Live projects insert a comment at Y=170px — the drawable area ends 1px before it (Y=0–168)
- Width varies: ~190px (Cabinet) to ~1050px (Echo, Corpus); typical ~400–600px
- To prevent Live from adding extra padding/borders around the device, set `Initial Window Size` to the exact width and height of the device (set origin to `0. 0.`)

## Layout Patterns

### Horizontal Row (simplest)
Row of dials, optionally with a visual area above.
- Examples: Amp, Channel EQ, Overdrive

### Controls Flanking Center Visual
Large visual area in center, controls on left and right.
- Examples: Compressor, Gate, Auto Filter, Saturator, Hybrid Reverb

### Multi-Section Horizontal
Distinct functional sections side by side, each with its own dark panel and header label.
- Examples: Reverb, Corpus, Resonators, Granulator III

### Vertical/Narrow Column
Controls stacked vertically.
- Examples: Cabinet, Pedal, Redux

### Expand/Collapse
Collapsed (compact) and expanded (visual display) views via disclosure triangle.
- Examples: Compressor, Phaser-Flanger

## Signal Flow Convention

Left-to-right: input controls → processing/visuals → output controls. Dry/Wet nearly always bottom-right.

## Visual/Graph Areas

- Always on a **dark background** (`themecolor.live_lcd_bg`)
- Center or center-right of device, 40–70% of area
- Dark background sections for visual content typically extend all the way to the bottom of the device (the standard 2px margin at the bottom falls outside the drawable area)
- Dials/sliders **never** on dark background; numboxes/toggles/menus/tabs **can** be

## Spacing

- **2px** between colored sections (including from the device border)
- 2px gaps between control group panels
- Consistent dial sizing within a row (~50x48px)

## Control Grouping

- Related controls get their own background panel (`themecolor.live_surface_bg`)
- Separated by 5px gaps
- `live.line` for thin dividers within sections

## Tabs

- True `live.tab` page-switching is **rare**
- For view switching, use the **ubutton + icon + hidden** pattern
- Mode-switching button bars (segmented `live.text`) more common than `live.tab`
- Tabs use a black background, and the selected tab visually connects to the black content area below it (tab bar and visual area appear as one continuous black region)

## Labels

- Static: `comment`, "Ableton Sans Medium" 9.5pt (or "Arial Bold" 10pt)
- Section headers: "Ableton Sans Bold" 14pt
- Pattern: label above, value below
- Labels on dark backgrounds: `themecolor.live_lcd_control_fg_zombie`

## Z-Order

Correct ordering (top to bottom of boxes array):
1. Interactive controls (dials, buttons, labels)
2. Transparent overlays (ubutton, lcd)
3. Visual content (bpatcher, spectroscope~, waveform~)
4. Control group panels (`live_surface_bg`)
5. Dark/LCD panels (`live_lcd_bg`)
6. Device background panel — **always last**
