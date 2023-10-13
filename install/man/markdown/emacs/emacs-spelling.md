# `emacs` Spelling

- `C-.` / `C-M-i` / `flyspell-auto-correct-word` (`C-.` and `C-M-i` don't work in terminal): Correct word at point
- `C-;` / `flyspell-correct-word-before-point` (`C-;` doesn't work in terminal): Correct previous word
- `C-c $` is the only spelling correction binding that works in terminal

## Add to Dictionary

- `C-c $` / `flyspell-correct-word-before-point`: Pop-up with option to add word to the dictionary
- `M-$ i`: Also adds the word to the dictionary

The variable `ispell-personal-dictionary` has personal dictionary path.

## On Demand Spell Checking

- `flyspell-buffer`: On demand check buffer
- `flyspell-region`: On demand check region
