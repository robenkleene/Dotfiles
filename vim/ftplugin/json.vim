" setlocal equalprg=python\ -m\ json.tool
" let b:FormatPrg = "python -m json.tool"
let b:FormatPrg = "prettier --parser json"
" This uses the correct indent level, but adds spaces to th end of each line
" let b:FormatPrg = "python -c \"import json, sys; print json.dumps(json.load(sys.stdin), indent=2)\""

" Disable Conceal
" let g:vim_json_syntax_conceal = 0

command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <leader>f  :Prettier<CR>
