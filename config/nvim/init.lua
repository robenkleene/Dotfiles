-- Set before plugins that require this
vim.o.termguicolors = true
-- Set leader now so later bindings pick it up
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

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

local f=io.open(vim.env.HOME .. '/.nvim_local.lua')
if f~=nil then io.close(f)
  dofile(vim.env.HOME .. '/.nvim_local.lua')
end
