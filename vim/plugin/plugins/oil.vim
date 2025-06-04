if !has("nvim")
  finish
endif

lua << EOF
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
EOF
