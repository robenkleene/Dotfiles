return {
  s("title",
    fmt(vim.fn.system("markdown_title " .. vim.fn.fnameescape(vim.fn.expand('%'))), { })
  )
}
