return {
  'stevearc/oil.nvim',
  config = function()
    require("oil").setup({
      win_options = {
        number = false,
      },
      keymaps = {
        ["~"] = function()
          vim.cmd.lcd(require("oil").get_current_dir())
        end,
      }
    })
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
  end
}
