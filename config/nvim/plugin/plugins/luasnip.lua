vim.cmd([[
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/Code/User/snippets" } })

local s = luasnip.snippet
local fmt = require("luasnip.extras.fmt").fmt
-- luasnip.add_snippets("markdown", {
--   s("title",
--     fmt(vim.fn.system("markdown_title " .. vim.fn.fnameescape(vim.fn.expand('%'))), { })
--   ),
-- })
