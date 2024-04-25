-- Use `cmp` because `luasnip` doesn't support Vim builtin completion
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    {
      'L3MON4D3/LuaSnip',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load({
          paths = { '~/.config/Code/User/snippets' }
        })
        local f=io.open(vim.env.HOME .. '/.local_snippets/package.json')
        if f~=nil then io.close(f)
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.local_snippets/" } })
        end
        local luasnip = require 'luasnip'
        vim.api.nvim_set_keymap(
          'i', '<Tab>',
          'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"',
          { expr = true, silent = true }
        )
        vim.keymap.set({'s'}, '<Tab>', function() luasnip.jump(1) end, { silent = true })
        vim.keymap.set({'i', 's'}, '<S-Tab>', function() luasnip.jump(-1) end, { silent = true })
        luasnip.filetype_extend("zsh", { "sh" })
        luasnip.filetype_extend("typescript", { "javascript" })
      end
    }
  },
  -- Set the same for cmp, treesitter, lsp
  ft = {
    "c",
    "cpp",
    "css",
    "html",
    "java",
    "javascript",
    "json",
    "jsx",
    "kotlin",
    "lua",
    "markdown",
    "python",
    "ruby",
    "rust",
    "scss",
    "sh",
    "typescript",
    "toml",
    "vim",
  },
  config = function()
    local cmp = require 'cmp'
    cmp.setup {
      -- Setting `keyword_length` breaks for `vsnip` but works for `luasnip`
      completion = {
        -- Don't offer completion until two characters, greatly reduces churn
        keyword_length = 2,
      },
      snippet = {
        expand = function(args)
          require'luasnip'.lsp_expand(args.body)
        end
      },
      formatting = {
        -- Truncate completion items to `20` characters
        -- Fixes a problem of the menu width jumping around too much as candidates change
        format = function(_, vim_item)
          local MAX_LENGTH = 30
          local MARKER = "…"
          if string.len(vim_item.abbr) > MAX_LENGTH then
            vim_item.abbr = string.sub(vim_item.abbr, 1, MAX_LENGTH) .. MARKER
          end
          return vim_item
        end
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        -- Don't use `<tab>` to cycle complete menus, or `<return> to select, because those don't work in default completion menus (e.g., for `C-n` and `C-x C-f`)
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- Don't include text in buffers, this creates a lot of noise in
        -- Markdown buffers, and `<C-n>` completion can already be used for
        -- that.
        -- Don't include paths because these aren't LSP features
        -- Include snippets because there's no builtin completion for snippets
      },
    }
    -- Only way to enter snippets now is to select them via completion
    -- vim.cmd([[
    -- augroup NvimCmp
    --   au!
    --   au FileType markdown lua require('cmp').setup.buffer { enabled = false }
    -- augroup END
    -- ]])
  end
}
