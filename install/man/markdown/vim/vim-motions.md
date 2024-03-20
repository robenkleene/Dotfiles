- `g_`: End of line without new line

# By Edit

- ```[`` / ```]``: Start or end of most recent edit

# By Visual Line

- `g0`: Beginning of display line
- `g$`: End of display line
- `gj`: Up display line
- `gk`: Down display line

# By Change

- `'[` / `']` (or backtick brace): Start / end of last change

# By Function

- `]]` / `][`: Next `{` / next `}` (start of next function, end of current function)
- `[[` / `[]`: Previous `{` / previous `}` (start of current function, end of previous function)

# By Sentence

- `(` / `)`: Next / preview sentence

## By Character

- `t{char}` & `T{char}`: To before next and previous character
- `f{char}` & `F{char}`: To next and previous character
- `;` & `'`: To next and previous of searched character
