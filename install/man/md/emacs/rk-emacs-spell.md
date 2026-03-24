- `C-.`, `C-M-i`, `flyspell-auto-correct-word`: Correct word at point (`C-.` and `C-M-i` don't work in terminal)
- `C-c $`, `flyspell-correct-word-before-point`: Correct word at point in a pop-up menu (works in terminal)
- `M-$`, `ispell-word`: Correct word at point in another buffer with numbers to choose, and more options (work in terminal)

# Add to Dictionary

- `C-c $` / `flyspell-correct-word-before-point`: Pop-up with option to add word to the dictionary (works in terminal)
- `M-$ i`: Also adds the word to the dictionary (works in terminal)

The variable `ispell-personal-dictionary` has personal dictionary path.

# On Demand Spell Checking

- `flyspell-buffer`: On demand check buffer
- `flyspell-region`: On demand check region
