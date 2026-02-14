---
name: maxmsp-m4l-ui
description: Design Max for Live device user interfaces. Use when creating or refining M4L device layouts and presentation mode.
allowed-tools: Read, Write, Edit, Grep, Glob
---

# Max for Live Device UI Design

## Device Constraints

- M4L devices display in Live's device chain with a fixed height and variable width
- Default device width is 254px; design for compact, efficient layouts
- Use presentation mode for the user-facing interface; patching mode is for the underlying logic

## UI Object Palette

- Prefer `live.*` UI objects (`live.dial`, `live.slider`, `live.button`, `live.menu`, `live.text`, `live.tab`, `live.numbox`) for Live-consistent look and feel
- `live.*` objects support parameter automation and mapping out of the box
- Use `comment` for labels (with `textcolor` for visibility on dark backgrounds)

## Layout Architecture

A typical M4L device layout has these sections:

```
+------+------------------------------------------+-----------+
| Tabs |  [Tab1]  [Tab2]                          |           |
+------+------------------------------------------+  Control  |
|      |                                          |  Group 1  |
| Side |        Visual Area                       |           |
| Tab  |        (bpatcher for swappable content)  +-----------+
|      |                                          |  Control  |
|      |                                          |  Group 2  |
+------+------------------------------------------+-----------+
| Btn  |  Labels / Info                           | Btn | Btn |
+------+------------------------------------------+-----------+
```

- **Tab bar** at top for switching content views
- **Side tabs** (vertical `live.tab`) for sub-modes
- **Center area** with a `bpatcher` for swappable visual content
- **Right column** with grouped dials/controls on their own background panels
- **Bottom strip** for toggles, labels, status

## Design Guidelines (Ableton M4L Production Style)

### Visual Content Areas
- Use a **black background** (`bgcolor [0,0,0,1]`) for visual content like graphs, spectroscopes, waveforms
- Graphical controls (dials, sliders) **never** go on the black background
- Number controls, toggles (`live.text`), pull-down menus, and tabs **can** go on the black background
- The black background section typically extends to the bottom of the device (with standard 5px margin)

### Spacing
- **5 pixels** separate colored sections (including from the device border)
- 5px gaps between control group backgrounds
- 5px gaps between groups and adjacent sections (black panel, device edge)

### Control Grouping
- Groups of related controls (e.g., Freeze+Attack or Decay+Gain) get their **own background panel**
- Use subtle contrast between group panels and the device background (e.g., group bgcolor [0.75] on device bgcolor [0.68])
- Avoid extreme contrast between group panels and background — the difference should be visible but not jarring

### Tab Styling
- Tabs ideally use a black background that visually connects to the black content area below (the tab bar and visual area appear as one continuous black region)
- This mimics Ableton's AutoShift-style tab design

## Z-Order for Panels (Critical)

The `boxes` array order determines z-order. First = on top, last = behind.

Correct ordering (top to bottom of array):
1. Interactive controls (`live.dial`, `live.tab`, `live.text`, `comment` labels)
2. `bpatcher` (visual content area)
3. Control group panels (lighter background, e.g., [0.75, 0.75, 0.75])
4. Black panel (visual content background, [0.0, 0.0, 0.0])
5. Device background panel (overall bg, e.g., [0.68, 0.68, 0.68]) — **always last**

If a panel is placed before controls in the array, it will cover them and they'll be invisible.

## Common Control Configurations

### live.dial (Continuous Parameter)
- Size: ~41x48 px is standard for a compact dial with label
- Use `parameter_exponent: 3.0` for time-based parameters (attack, decay, freeze) for better feel
- Unit styles: `2` = ms, `4` = dB, `1` = float

### live.text (Toggle/Momentary Button)
- Size: ~41x15 px for compact toggle buttons
- Set `mode: 0` for momentary (click = bang), omit for toggle
- `text` = off label, `texton` = on label (can be same for always-visible label)
- Good for: Mute, Clear, Reverse, transport controls

### live.tab (Tab Selector)
- Horizontal: `num_lines_presentation: 1`
- Vertical: `num_lines_presentation: N` (one line per tab)
- Labels via `parameter_enum` array

### spectroscope~ (Frequency Analyzer)
- Use `logfreq: 1` for logarithmic frequency scale
- `domain: [20.0, 20000.0]` for full audible range
- `fgcolor` for waveform color, `markercolor` for grid lines
- Add `comment` labels below for frequency markers (100, 1k, 10k) positioned along log scale

### waveform~ + live.drop (Sample Display)
- Overlay `live.drop` on top of `waveform~` at the same `presentation_rect`
- `live.drop` provides drag-and-drop; `waveform~` shows the loaded waveform
- Link both to a `buffer~` object via `buffername`

## Sizing Reference

Typical device dimensions for a medium-complexity M4L device:
- Width: ~560px
- Height: ~200px
- Visual area: ~400x120px
- Dial columns: ~95px wide (fits 2 dials side by side at 41px each + gaps)

## Styling

- Match Live's native color palette and visual weight
- Avoid excessive color variation; use color sparingly to indicate groupings or state
- Maintain sufficient contrast for readability
- White text (`textcolor [1,1,1,1]`) for labels on black backgrounds
- For theme compatibility, avoid hardcoding colors where possible — but panels need explicit `bgcolor` to create visual grouping contrast
