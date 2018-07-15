command! Format :%!python -m json.tool
nnoremap <localleader>f :Format<CR>

" Disable Conceal
" let g:vim_json_syntax_conceal = 0
