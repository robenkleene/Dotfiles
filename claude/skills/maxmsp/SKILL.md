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
