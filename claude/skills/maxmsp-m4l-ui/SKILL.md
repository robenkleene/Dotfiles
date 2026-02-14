---
name: maxmsp-m4l-ui
description: Design Max for Live device user interfaces. Use when creating or refining M4L device layouts and presentation mode.
disable-model-invocation: true
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
- Use `live.comment` for labels rather than plain `comment`

## Layout Guidelines

- Align controls to a grid for visual consistency
- Group related parameters horizontally; separate groups with vertical spacing
- Place labels above or to the left of their associated controls
- Keep the most important controls visible without scrolling

## Styling

- Match Live's native color palette and visual weight
- Avoid excessive color variation; use color sparingly to indicate groupings or state
- Maintain sufficient contrast for readability
