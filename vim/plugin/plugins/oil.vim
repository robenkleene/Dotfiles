if !has("nvim")
  finish
endif

lua << EOF
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
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
EOF
