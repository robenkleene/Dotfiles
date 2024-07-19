return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require 'cmp'
    cmp.setup {
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
        ['<C-x><C-u>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
  end
}
