return {
  'L3MON4D3/LuaSnip',
  -- This can't co-exist with GitHub Copilot
  -- keys = {
  --   { '<Tab>', mode = "i" },
  -- },
  event = "VeryLazy",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/Code/User/snippets" } })
    local f=io.open(vim.env.HOME .. '/.local_snippets/package.json')
    if f~=nil then io.close(f)
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.local_snippets/" } })
    end
    vim.api.nvim_set_keymap(
      'i', '<Tab>',
      'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"',
      { expr = true, silent = true }
    )
    local luasnip = require 'luasnip'
    luasnip.filetype_extend("zsh", { "sh" })
    luasnip.filetype_extend("typescript", { "javascript" })
  end
}
