abbr --add -- - 'cd -'
abbr --add hd history delete -eC
abbr --add printf_var printf '%s\n'

if test -f ~/.local_abbr.fish
    source ~/.local_abbr.fish
end
