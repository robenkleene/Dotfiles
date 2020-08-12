" setlocal equalprg=tidy\ -quiet\ --show-errors\ 0
" let b:FormatPrg = "tidy -quiet --show-errors 0"
" Since Markdown supports inline HTML, `html.vim` is sourced for Markdown as
" well
if &ft=="markdown"
  finish
endif

let b:FormatPrg = "prettier --parser html"
