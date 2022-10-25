vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.cmd([[
nnoremap <leader>oi :cd ~/Developer/Dotfiles/config/nvim/<CR>:edit init.lua<CR>:echo ""<CR>
nnoremap cl :lcd %:p:h<CR>
nnoremap <expr> <M-n> len(getqflist()) ? ":cn<CR>" : len(argv()) > 1 ? ":next<CR>" : ":Fnext<CR>"
nnoremap <expr> <M-p> len(getqflist()) ? ":cp<CR>" : len(argv()) > 1 ? ":prev<CR>" : ":Fprev<CR>"
" Quickfix
nnoremap <leader>q :call bindings#ToggleQuickfixList()<CR>
nnoremap <leader>cq :GrepBufferFromClipboard<CR>
" Text Editing
inoremap <M-BS> <C-W>
nnoremap <localleader>w :set wrap!<CR>
nnoremap <leader>w :set wrap!<CR>
" Tabs
nnoremap <C-w>t :split<CR><C-w>T
vnoremap <C-w>t :split<CR><C-w>T
nnoremap <C-w>q :tabclose<CR>
vnoremap <C-w>q :<C-u>tabclose<CR>
nnoremap <C-w>n gt
nnoremap <C-w>p gT
vnoremap <C-w>n gt
vnoremap <C-w>p gT
" Clipboard
nnoremap <space>p "*p
nnoremap <space>P "*P
vnoremap <space>p "*p
vnoremap <space>P "*P
nnoremap <space>y "*y
vnoremap <space>y "*y
" Command Line
cnoremap <C-A> <Home>
]])

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

