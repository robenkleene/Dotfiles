return {
  'hrsh7th/vim-vsnip',
  event = 'VeryLazy',
  config = function()
    vim.cmd([[
    let g:vsnip_snippet_dir = '~/.config/Code/User/snippets'

    imap <expr> <Tab>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
    smap <expr> <Tab>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

    let g:vsnip_filetypes = {}
    let g:vsnip_filetypes.zsh = ['sh']
    let g:vsnip_filetypes.typescript = ['typescript']
    ]])
  end
}

