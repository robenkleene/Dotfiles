return {
  'hrsh7th/nvim-cmp', dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip'
  },
  -- Set the same for cmp, treesitter, lsp
  ft = {
    "c",
    "cpp",
    "css",
    "html",
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
    local luasnip = require 'luasnip'
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
    vim.cmd([[
    augroup NvimCmp
      au!
      au FileType markdown lua require('cmp').setup.buffer { enabled = false }
    augroup END
    ]])
  end
}
