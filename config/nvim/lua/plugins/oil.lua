return {
  'stevearc/oil.nvim',
  config = function()
    require("oil").setup({
      win_options = {
        number = false,
      }
    })
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
  end
}
