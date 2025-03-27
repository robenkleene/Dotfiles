" `:h netrw_preview`
" By default, `p` previews doing the reverse of `splitbelow`, e.g., if
" `splitbelow` is on, then the preview opens above
" This makes the preview match the split setting
if &splitbelow
  let g:netrw_alto = 0
else
  let g:netrw_alto = 1
endif
