setlocal foldlevel=2

" If `eval('@%')` is empty, than this isn't backed by a file
" Setting `buftype=nofile readonly nomodifiable` makes it easier to use diffs
" generated from commands as a diff viewer
" Disabling for now, can probably just use, e.g., `Shn! git diff`, by
" convention now
" if eval('@%') == ''
"   setlocal buftype=nofile readonly nomodifiable
" end
