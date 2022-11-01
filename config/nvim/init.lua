-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- Set before plugins that require this
vim.o.termguicolors = true
-- Set leader now so later bindings pick it up
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'                                                         -- Package manager
  use "gpanders/editorconfig.nvim"
  use "elihunter173/dirbuf.nvim"
  use 'numToStr/Comment.nvim'
  use { 'L3MON4D3/LuaSnip' }
  use({
      "NvChad/nvim-colorizer.lua",
      config = function()
          require("colorizer").setup()
      end
  })
  use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  })
  -- UI
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
    end
  }
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
  -- Languages
  use { 'dag/vim-fish', ft = {'fish'}, }

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

