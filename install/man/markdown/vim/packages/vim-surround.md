%

# `vim` Surround

- `cst`: Change HTML tag
- `St`: Change HTML tag for visual selection
- `cs"'`: Change double quote to single quote
- `ds"`: Delete double quotes
- `ysw"`: Wrap word in double quotes
	- You probably want to use `ysiw"`, because that will work anywhere, not just at the beginning of the word
- `S"`: Add quotes to the visual selection

## Repeat

- Repeat for `.` doesn't work with `S` for surround visual selection

## Pairs

- With pairs the left pair (e.g., `[`) inserts with space arround (e.g., `[ foo ]`), while the right pair (e.g., `]`) inserts without space around (e.g., `[foo]`)
