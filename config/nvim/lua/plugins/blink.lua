return {
  'saghen/blink.cmp',
  -- Use a release for pre-built binaries
  version = 'v0.*',
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "markdown", "text", "gitcommit", "hgcommit" }, vim.bo.filetype) and vim.bo.buftype ~= "prompt"
    end,
    appearance = {
      -- Fix icon spacing
      nerd_font_variant = 'normal'
    },
    snippets = {
      expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction) require('luasnip').jump(direction) end,
    },
    sources = {
      default = { 'lsp', 'path', 'luasnip', 'buffer' },
    },
  },
}
