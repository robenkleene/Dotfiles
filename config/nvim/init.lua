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
  use 'wbthomason/packer.nvim'
  use "gpanders/editorconfig.nvim"
  use {
    "elihunter173/dirbuf.nvim",
    -- Disabling this because then it won't be available for `nvim .`
    -- keys = "-",
    config = function()
      require("dirbuf").setup {
        show_hidden = false,
      }
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/Code/User/snippets" } })
      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
      ]])
    end
  }
  use {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end
  }
  use {
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup()
    end
  }
  use {
    -- Use `B` command to pipe just part of a visual selection
    'vim-scripts/vis',
    cmd = "B"
  }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
        }
      }
    end
  }
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle'
  }
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    -- Not due to a bug, `require` aren't lazy loaded
    requires = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable "make" == 1
      },
      { 'nvim-lua/plenary.nvim' },
    },
    keys = {
      '<leader>b',
      '<leader>l',
      '<leader>F',
      '<leader>/',
      '<leader>s',
      '<leader>S',
    },
    config = function()
      require('telescope').setup()
      pcall(require('telescope').load_extension, 'fzf')
      vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
      vim.keymap.set('n', '<leader>l', require('telescope.builtin').current_buffer_fuzzy_find)
      vim.keymap.set('n', '<leader>F', require('telescope.builtin').find_files)
      vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep)
      vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
      vim.keymap.set('n', '<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    end
  }
  -- Languages
  use { 'dag/vim-fish', ft = { 'fish' }, }

  if vim.fn.filereadable(vim.fn.expand("~/.nvim_local/nvim_local.lua")) ~= 0 then
    package.path = os.getenv("HOME") .. "/.nvim_local/" .. package.path
    local nvim_local = require("nvim_local")
    nvim_local.packer_continue(use)
  end

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
