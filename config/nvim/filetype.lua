-- Extensions
vim.filetype.add({ extension = { omnijs = "javascript" } })
vim.filetype.add({ extension = { m = "objc" } })
vim.filetype.add({ extension = { plist = "xml" } })
vim.filetype.add({ extension = { pde = "java" } })

-- Filenames
vim.filetype.add({ filename = { eslintrc = "json" } })
vim.filetype.add({ filename = { Brewfile = "conf" } })

-- Special
vim.filetype.add {
  pattern = {
    ['.*'] = {
      priority = -math.huge,
      function(path, bufnr)
        local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ''
        if vim.regex([[^changeset:]]):match_str(content) ~= nil then
          -- Interpret `hg show` output as `diff`
          return 'diff'
        end
      end,
    },
  },
}
