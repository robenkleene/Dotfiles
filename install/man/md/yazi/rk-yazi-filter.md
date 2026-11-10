- `f`: Filter files in the current directory (e.g., `f` then `.png` to only show PNGs)
- `s`: Search for files with `fd` (includes subdirectories)

# Active Filter

- `<Enter>`: Keep the filter while navigating
- `<Esc>`: Clear the filter (also works after it's been kept with `<Enter>`)

# Patterns

- Filters are regexes (e.g., `\.png$` only matches names ending in `.png`, while `.png` matches `.png` anywhere in the name)
- Filters are smart case: lowercase matches both cases (e.g., `png` matches `.PNG`), and any uppercase makes the filter case sensitive
