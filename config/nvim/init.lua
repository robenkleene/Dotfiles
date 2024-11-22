-- Set before plugins that require `termguicolor`
vim.o.termguicolors = false
-- Turn off smartindent since we have tree sitter indent on
vim.o.smartindent = false
-- Set leader now so later bindings pick it up
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- vim.cmd[[colorscheme wildcharm]]

-- Prevent the builtin `:Man` command from being loaded, we're using a plugin because it has better tab completion
vim.g.loaded_man = 1

vim.cmd[[
if $TERM_PROGRAM != "Apple_Terminal" || exists('$SSH_CONNECTION') || exists('$TMUX')
  set background=dark
endif
colorscheme lunaperche
]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup("plugins", {
  change_detection = {
    -- This is noisy when working on config
    notify = false,
  }
})

-- `vim-vinegar` does this interally to use sorting based on suffixes, but for
-- some reason it doesn't work in Neovim, it also doesn't work as a config
-- function for `vim-vinegar`
vim.cmd([[
function! s:sort_sequence(suffixes) abort
  return '[\/]$,*' . (empty(a:suffixes) ? '' : ',\%(' .
        \ join(map(split(a:suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$')
endfunction
let g:netrw_sort_sequence = s:sort_sequence(&suffixes)
]])

local f=io.open(vim.env.HOME .. '/.nvim_local.lua')
if f~=nil then io.close(f)
  dofile(vim.env.HOME .. '/.nvim_local.lua')
end
