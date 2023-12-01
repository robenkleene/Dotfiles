-- Set before plugins that require this
vim.o.termguicolors = true
-- Set leader now so later bindings pick it up
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- This setting only works here
vim.g.unception_enable_flavor_text = false
-- This makes in insert mode on edit
vim.g.unception_delete_replaced_buffer = true

vim.cmd([[command! Ei :edit ~/Developer/Dotfiles/config/nvim/init.lua ]])

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
    notify = false,
  }
})

-- These don't work in the `telescope.lua` file for some reason
vim.keymap.set('n', '<localleader>D', require('telescope.builtin').diagnostics)
vim.keymap.set('n', '<localleader>i', require('telescope.builtin').lsp_document_symbols)
vim.keymap.set('n', '<localleader>I', require('telescope.builtin').lsp_dynamic_workspace_symbols)
vim.keymap.set('n', '<localleader>R', require('telescope.builtin').lsp_references)
