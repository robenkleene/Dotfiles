" `:h netrw_preview`
" By default, `p` previews doing the reverse of `splitbelow`, e.g., if
" `splitbelow` is on, then the preview opens above
" This makes the preview match the split setting
if &splitbelow
  let g:netrw_alto = 0
else
  let g:netrw_alto = 1
endif

" Make `netrw` `lcd` to the current directory being viewed
" This makes it more predictable, without this, it's easy to, e.g., run
" `mkdir` and make a directory in the current working directory, instead of
" the viewed directory.
" Note that relative to the rest of Vim, `netrw` already behaves a bit
" strangely, since whenever a `netrw` buffer is entered, it `:lcd` to that
" directory (which means `echo haslocaldir()` will always print `1` from
" `netrw`. This means keeping this option is less impactful in the context of
" `netrw` then it would be otherwise, because `netrw` already ignores the
" typical global (`:cd`) vs buffer (`:lcd`) working directory split.
" Turning this off, this seems to exasperate issues with `-` finding the
" current file in `netrw`.
" let g:netrw_keepdir = 0
