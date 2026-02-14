---
name: maxmsp-m4l-ui
description: Design Max for Live device user interfaces. Use when creating or refining M4L device layouts and presentation mode.
allowed-tools: Read, Write, Edit, Grep, Glob
---

# Max for Live Device UI Design

## Device Constraints

- M4L devices display in Live's device chain with a fixed height and variable width
- Width varies by complexity: ~190px (Cabinet) to ~1050px (Echo, Corpus)
- A typical medium device is ~400–600px wide
- Use presentation mode for the user-facing interface; patching mode is for the underlying logic

## UI Object Palette

- Prefer `live.*` UI objects (`live.dial`, `live.slider`, `live.button`, `live.menu`, `live.text`, `live.tab`, `live.numbox`) for Live-consistent look and feel
- `live.*` objects support parameter automation and mapping out of the box
- Use `comment` for static labels, `live.comment` for dynamic text
- Use `live.line` for thin divider lines between sections

## Layout Patterns

Ableton devices use several structural approaches depending on complexity:

### Horizontal Row (simplest)
A single horizontal row of dials, optionally with a visual area above. Used by simpler effects.
- Examples: Amp (5 dials in a row), Channel EQ (curve above, 4 dials below), Overdrive

### Controls Flanking Center Visual
The most common pattern for complex devices. A large visual/graph area occupies the center, with parameter controls on left and right.
- Examples: Compressor, Gate, Auto Filter, Saturator, Hybrid Reverb, Vocoder

### Multi-Section Horizontal
The device is divided into distinct functional sections side by side, each with its own dark background panel and header label.
- Examples: Reverb (Input Filter, Early Reflections, Diffusion Network, Chorus as separate panels), Corpus, Resonators, Granulator III (Envelopes | Filter+LFO side by side)

### Vertical/Narrow Column
Very compact devices with controls stacked vertically.
- Examples: Cabinet (dropdowns + 1 dial), Pedal, Redux

### Expand/Collapse
Some devices have a collapsed view (compact controls or meters only) and an expanded view (reveals visual display area). Triggered by a disclosure triangle in the title bar.
- Examples: Compressor (collapsed = meters, expanded = waveform), Phaser-Flanger (expanded adds LFO/modulation section)

## Signal Flow Convention

Layouts follow audio signal flow left-to-right:
- **Left side**: Input controls (Drive, Send, input selectors)
- **Center**: Processing controls and visual displays
- **Right side**: Output controls (Dry/Wet, Output/Gain)
- **Dry/Wet** is nearly universal and almost always in the **bottom-right corner**

## Visual/Graph Areas

- Used in the majority of devices for frequency curves, waveforms, meters, spectrograms, transfer curves, etc.
- Always on a **dark/near-black background** contrasting with the lighter gray surrounds
- Positioned in the **center or center-right** of the device, never on the extreme edges
- Typically occupy 40–70% of the device's total area in visualization-heavy devices
- Graphical controls (dials, sliders) **never** go on the dark background
- Non-graphical controls (number boxes, toggles, menus, tabs) **can** go on the dark background

## View Switching (Tab-like Behavior)

The correct pattern for switching between views (e.g., waveform vs controls) uses **`ubutton` + `live.text` icons + `hidden` toggling**, not `live.tab`:

### Architecture (as used in Granulator III)
1. **Visual indicator**: `live.text` with SVG icon (`usepicture: 1`, `remapsvgcolors: 1`, `ignoreclick: 1`) — display-only, shows which view is active via on/off color state
2. **Click target**: `ubutton` (invisible, `hltcolor` alpha 0.0) overlaid on the icon — handles the actual click, stores toggle state as a parameter
3. **View content**: Multiple `bpatcher` objects at the **same `presentation_rect`** — one for each view (e.g., waveform bpatcher, envelopes+filter bpatcher)
4. **Switching logic**: ubutton output → logic → `thispatcher` receives `script sendbox <varname> hidden $1` messages to show/hide each bpatcher

### Why not `live.tab`?
`live.tab` provides basic tab selection but doesn't integrate with the dark-panel visual style. The `ubutton` + icon pattern allows full control over the visual appearance — icons on dark backgrounds, theme-colored active states, and seamless integration with the panel layout.

### Key details:
- View toggle icons use `activetextoncolor` with `themecolor.live_value_arc` for the active state (cyan highlight)
- Inactive state uses a dimmed color (`activetextcolor` set to gray)
- Background colors set to transparent (alpha 0.0) so icons float on the dark panel
- The `ubutton` has `parameter_invisible: 2` (hidden from automation but stores state)

## Background Colors and Sections

### Theme Colors for Panels (prefer these over hardcoded colors)
- **`themecolor.live_lcd_bg`** — dark panel background (for visual/content areas)
- **`themecolor.live_surface_bg`** — device surface / control group background
- **`themecolor.live_macro_title`** — title/header bar backgrounds

Apply via `saved_attribute_attributes.bgfillcolor.expression`.

### Panel Properties
- Use `panel` with `mode: 0` for filled rectangles
- `rounded: 4` for subtle corner rounding (matches Ableton style)
- `proportion: 0.39` or `0.5` for fill behavior

### Section Separation
Sections are separated by:
- `live.line` objects (thin divider lines between functional areas)
- Background color shifts (dark panel vs lighter surface)
- Proximity-based grouping (tight spacing within groups, wider gaps between groups)

### Accent Colors
- **Cyan/turquoise** (`themecolor.live_value_arc`): Primary accent — dial arcs, active values, active view icons
- **Orange/amber** (`themecolor.live_active_automation`): Secondary accent — automation indicators, active toggles
- **White/light gray**: Labels, inactive text, dial outlines
- **Green**: Metering only (gain reduction bars, tuner indicator)

## Spacing Rules

- **5 pixels** separate colored sections (including from the device border)
- 5px gaps between control group panels and between groups and adjacent sections
- ~4–8px padding between device frame edge and first controls
- Consistent dial sizing within a row (typically ~50x48px with label)

## Control Grouping

- Groups of related controls get their own background panel
- Use `themecolor.live_surface_bg` for group panels to automatically match theme
- Related dials are placed side by side in horizontal pairs or rows
- Groups are separated by 5px gaps

## Tabs

- True page-switching tabs (`live.tab`) are **rare** — only for the most complex devices
- Most devices present all controls on a single flat panel
- For view switching (showing/hiding content areas), use the **ubutton + icon + hidden** pattern instead (see "View Switching" above)
- Mode-switching button bars (segmented `live.text` radio buttons) are more common than `live.tab` for switching between 2–3 modes

## Label Conventions

- Static labels: `comment` with "Ableton Sans Medium" at 9.5pt (or "Arial Bold" at 10pt)
- Section headers: "Ableton Sans Bold" at 14pt
- Standard pattern: **label above** the control, **value below**
- Values display in cyan (`themecolor.live_value_arc`) with inline units (e.g., "100 ms", "-6.2 dB")
- Labels on dark backgrounds use `themecolor.live_lcd_control_fg_zombie` (dimmed secondary text)
- `_zombie` suffix = dimmed/inactive variant of a theme color

## SVG Icon Pattern

For multi-state visual indicators (grain mode, filter type, LFO shape, view icons):

1. Create multiple `live.text` objects at the **same `presentation_rect`**, each with a different SVG picture
2. Set all to `hidden: 1` and `ignoreclick: 1` except the active one
3. Enable `remapsvgcolors: 1` so SVGs adapt to theme colors
4. Overlay a transparent `ubutton` to handle clicks
5. Use logic to toggle `hidden` on the correct icon based on selection

## Common Control Configurations

### live.dial
- The dominant control type across all devices
- Size: ~50x48px is standard with label
- `parameter_exponent: 3.0` for time-based parameters (attack, decay) for better feel
- Unit styles: `2` = ms, `4` = dB, `1` = float

### live.text (Toggle/Momentary)
- Rectangular buttons, orange/yellow when active, gray when inactive
- `mode: 0` for momentary (bang), omit for toggle
- Size: ~41x15px for compact buttons
- Can display SVG icons with `usepicture: 1`

### Segmented Button Bars (Radio Buttons)
- Groups of 2–4 adjacent `live.text` buttons where exactly one is active
- Used for mutually exclusive modes (Peak/RMS/Expand, Repitch/Fade/Jump)

### live.menu / Dropdowns
- Indicated by a small downward triangle
- Used for preset/type selection (speaker types, IR selection, filter types)

### live.numbox
- Editable numeric value fields
- `lcdbgcolor` with transparent alpha for floating-on-panel look
- `lcdcolor` with `themecolor.live_value_arc` for accent color

### Visual Display Objects
- **`spectroscope~`**: Frequency analyzer — use `logfreq: 1`, `domain: [20, 20000]`
- **`waveform~`**: Audio waveform — link via `buffername`, theme via `themecolor.live_output_curve_color`
- **`live.drop`**: Drag-and-drop zone — overlay on `waveform~` at same position
- **`filtergraph~`**: Interactive filter frequency response curve
- **`live.adsrui`**: Graphical ADSR envelope editor

## bpatcher Best Practices

For seamless embedding of sub-patches:
```json
"bgmode": 0, "border": 0, "clickthrough": 0,
"enablehscroll": 0, "enablevscroll": 0,
"lockeddragscroll": 0, "lockedsize": 0,
"offset": [0.0, 0.0], "viewvisibility": 1
```

Each bpatcher sub-patch is a self-contained UI panel with its own coordinate system. Use `live.line` for visual dividers between sections within a bpatcher.

## Z-Order (Critical)

The `boxes` array order determines z-order in presentation. First = on top, last = behind.

Correct ordering (top to bottom of array):
1. Interactive controls (dials, tabs, buttons, labels)
2. Transparent overlays (ubutton, lcd)
3. Visual content objects (bpatcher, spectroscope~, waveform~)
4. Control group panels (`themecolor.live_surface_bg`)
5. Dark/LCD panels (`themecolor.live_lcd_bg`)
6. Device background panel — **always last**

If a panel is placed before controls in the array, it will cover them.
