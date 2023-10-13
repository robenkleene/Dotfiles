%

# Vim Troubleshooting

- `vim -u NONE`: Launch with no init

## Notes

If a binding with modifiers doesn't work, try entering it using `^v` followed by the bind combination. For example:

    nnoremap <M-O> :QuickFiles<CR>
    " For some reason the above binding doesn't work, but the below one does
    nnoremap O :QuickFiles<CR>

## Startup Time

- `vim --startuptime /dev/stdout +qall`: Dump startup time to `STDOUT` (the total is at the bottom)
    - The imported files don't seem listed this way? `vim --startuptime vim.log` lists the files
- `hyperfine "nvim --headless +qa" --warmup 5`: Is another method using `hyperfine`
