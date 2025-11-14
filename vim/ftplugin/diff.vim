setlocal foldlevel=2

" If `eval('@%')` is empty, than this isn't backed by a file
" Setting `buftype=nofile readonly nomodifiable` makes it easier to use diffs
" generated from commands as a diff viewer
if eval('@%') == ''
  setlocal buftype=nofile readonly nomodifiable
end
