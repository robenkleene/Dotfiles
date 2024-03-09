command! -range -nargs=+ -complete=command P silent <line1>,<line2>call commands#P(<q-args>)
command! -range -nargs=+ -complete=shellcmd Pp silent <line1>,<line2>call commands#P('!'.<q-args>)
" For some reason we need to add `-nargs=?` in order to support the expression
" register (`=`)
command! -register -nargs=? Putqf call commands#Putqf(<q-args>)
command! -nargs=+ Rg call commands#Rg(<q-args>)
command! -nargs=+ Fd call commands#Fd(<q-args>)
command! -nargs=+ Z call commands#Z(<q-args>)
command! -nargs=+ Lz call commands#Lz(<q-args>)
command! -nargs=1 Dc :all commands#Dc(<q-args>)
command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
