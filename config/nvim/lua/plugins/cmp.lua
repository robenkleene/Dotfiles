-- Use `cmp` because `luasnip` doesn't support Vim builtin completion
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-vsnip',
    {
      'hrsh7th/vim-vsnip',
      config = function()
        vim.cmd([[
        let g:vsnip_snippet_dir = '~/.config/Code/User/snippets'
        let g:vsnip_filetypes = {}
        let g:vsnip_filetypes.sh = ['shellscript']
        let g:vsnip_filetypes.zsh = ['sh']
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        ]])
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
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
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
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        -- Don't use `<tab>` to cycle complete menus, because that doesn't work in default completion menus (e.g., for `C-n` and `C-x C-f`)
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
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
