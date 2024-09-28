if filereadable('~/.local_snippets/package.json')
  let g:vsnip_snippet_dir = ['~/.config/Code/User/snippets', '~/.local_snippets']
else
  let g:vsnip_snippet_dir = '~/.config/Code/User/snippets'
endif

imap <expr> <Tab>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.sh = ['shellscript']
let g:vsnip_filetypes.zsh = ['shellscript']
let g:vsnip_filetypes.typescript = ['javascript']
