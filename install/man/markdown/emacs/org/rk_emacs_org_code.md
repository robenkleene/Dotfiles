- `C-c C-,` / `org-insert-structure-template` then `s`: Insert source code block (this binding doesn't work in terminal Emacs)
- With `(require 'org-tempo)`, inserting `<s` followed by tab will insert source code
- After `src` there's a space, enter the source code type for syntax higlighting (e.g., `src C++`)
- `C-c '`: Edit a code block (it's best to always use this because it will indent properly and handle things like inserting a `,` before lines starting with `*`)

# Executing

- `C-c C-c`: Execute source block

Example source configuration that will run an eshell command and, if it's a visual command, display it an a separate buffer:

``` shell
#+begin_src eshell :results output none :session eshell
cd ~/Dotfiles/Developer && git show
#+end_src
```

# Limitations

Lines starting with `*`, `,*`, `#+` or `,#+` need to be prefixed with a comma (otherwise they'll be interpreted as outline structure)
