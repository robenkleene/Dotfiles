return {
  'saghen/blink.cmp',
  -- Use a release for pre-built binaries
  version = 'v0.*',
  opts = {
    completion = {
      menu = {
        auto_show = function(ctx)
          if vim.tbl_contains({
            "markdown",
            "text",
            "gitcommit",
            "hgcommit" }, vim.bo.filetype) then
            return false
          end
          -- Disable for terminal mode
          if vim.bo.buftype == "prompt" then
            return false
          end
          -- Disable in command line
          if ctx.mode == 'cmdline' then
            return false
          end
          return true
        end
      }
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
