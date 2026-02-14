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
- Use `comment` for labels (with `textcolor` for visibility on dark backgrounds)

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
- Examples: Reverb (Input Filter, Early Reflections, Diffusion Network, Chorus as separate panels), Corpus, Resonators

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

## Background Colors and Sections

### Device Background
- All devices use a consistent **medium gray** as the primary device background

### Dark Panels
- Visual displays and grouped parameter sections use **dark charcoal/near-black** backgrounds
- These dark panels create clear "windows" into data or separate functional groups
- Labeled section headers appear at the top-left of dark panels (e.g., "Input Filter", "Early Reflections")

### Section Separation
Sections are separated by:
- Subtle vertical divider lines (thin, slightly different shade)
- Background color shifts (light gray vs dark panel)
- Proximity-based grouping (tight spacing within groups, wider gaps between groups)

### Accent Colors
- **Cyan/turquoise**: Primary accent — dial position arcs, frequency curves, threshold lines, active parameter values
- **Orange/amber**: Secondary accent — active/selected toggle buttons, highlighted selections, signal activity, waveform overlays
- **White/light gray**: Labels, inactive text, dial outlines
- **Green**: Metering only (gain reduction bars, tuner indicator)

## Spacing Rules

- **5 pixels** separate colored sections (including from the device border)
- 5px gaps between control group panels and between groups and adjacent sections
- ~4–8px padding between device frame edge and first controls
- Consistent dial sizing within a row (typically ~40–50px diameter)

## Control Grouping

- Groups of related controls get their own background panel (a `panel` with `mode: 0`)
- Use subtle contrast between group panel bgcolor and overall device background — visible but not jarring
- Related dials are placed side by side in horizontal pairs or rows
- Groups are separated by 5px gaps

## Tabs

- Tabs are **rare** — only used for the most complex devices with distinct pages/modes
- Most devices present all controls on a single flat panel
- When used, tab bars are always at the **top** of the device or section
- Examples: Hybrid Reverb (Reverb/EQ), Echo (Echo/Modulation/Character), Roar (Direct/Feedback)
- Mode-switching button bars (segmented radio buttons) are more common than true tabs for switching between 2–3 modes (e.g., Phaser/Flanger/Doubler, OD/Distort/Fuzz)

## Label Conventions

- Labels use a small, light sans-serif font in **white or light gray**
- Standard pattern: **label above** the dial, **value below** the dial
- Values display in **cyan** text with inline units (e.g., "100 ms", "5.29 s", "-6.2 dB")
- Section headers use larger or bolder text at the top-left of their dark panel
- Units are part of the value text, not separate labels

## Common Control Configurations

### live.dial
- The dominant control type across all devices
- Rendered as a circular arc with position indicator and colored value arc (cyan)
- Size: ~41x48px is standard for compact dial with label
- `parameter_exponent: 3.0` for time-based parameters (attack, decay) for better control feel
- Unit styles: `2` = ms, `4` = dB, `1` = float

### live.text (Toggle/Momentary)
- Rectangular buttons, orange/yellow when active, gray when inactive
- `mode: 0` for momentary (bang), omit for toggle
- `text` = off label, `texton` = on label
- Size: ~41x15px for compact buttons
- Used for: mute, enable/disable, mode toggles

### Segmented Button Bars (Radio Buttons)
- Groups of 2–4 adjacent `live.text` buttons where exactly one is active
- Used for mutually exclusive modes (Peak/RMS/Expand, Repitch/Fade/Jump)

### live.tab
- Used for page-switching tabs (not mode selection — use button bars for that)
- Horizontal: `num_lines_presentation: 1`
- Vertical: `num_lines_presentation: N` (one per line)
- Labels via `parameter_enum` array

### live.menu / Dropdowns
- Indicated by a small downward triangle
- Used for preset/type selection (speaker types, IR selection, scale selection)

### Visual Display Objects
- **`spectroscope~`**: Frequency analyzer — use `logfreq: 1`, `domain: [20, 20000]`
- **`waveform~`**: Audio waveform display — link via `buffername` to a `buffer~`
- **`live.drop`**: Drag-and-drop zone — overlay on `waveform~` at same position
- **`filtergraph~`**: Interactive filter frequency response curve

## Z-Order (Critical)

The `boxes` array order determines z-order in presentation. First = on top, last = behind.

Correct ordering (top to bottom of array):
1. Interactive controls (dials, tabs, buttons, labels)
2. Visual content objects (bpatcher, spectroscope~, waveform~)
3. Control group panels (subtle lighter background)
4. Dark/black visual area panels
5. Device background panel — **always last**

If a panel is placed before controls in the array, it will cover them.
