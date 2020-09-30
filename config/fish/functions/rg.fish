function rg
    # Adding `--line-number` interferes with piping to `rg`, but without it
    # piping to `vim` will also not have line numbers, so it needs to be turned
    # on here. To work around this, when piping to it use the `A` global alias.
    # alias rg="rg --with-filename --smart-case --line-number --colors
    # 'match:fg:black' --colors 'match:bg:cyan' --colors 'path:fg:cyan'
    # --colors 'line:fg:white'"
    if test -t 1
        command rg --with-filename --smart-case --line-number --colors 'match:fg:black' --colors 'match:bg:cyan' --colors 'path:fg:cyan' --colors 'line:fg:white' -p "$argv" | less -RFX
    else
        command rg --with-filename --smart-case --line-number "$argv"
    end
end
