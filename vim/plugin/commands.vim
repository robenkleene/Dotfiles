command! -range -nargs=+ -complete=command P silent <line1>,<line2>call commands#P(<q-args>)
command! -range -nargs=+ -complete=shellcmd PSh <line1>,<line2>call commands#P('!'.<q-args>)
" For some reason we need to add `-nargs=?` in order to support the expression
" register (`=`)
command! -nargs=+ -complete=shellcmd GrepSh call commands#GrepSh(<q-args>)
command! -nargs=+ -complete=shellcmd DiffSh call commands#DiffSh(<q-args>)
command! -nargs=+ -complete=shellcmd ArgsSh call commands#ArgsSh(<q-args>)
command! -nargs=+ -complete=shellcmd MakeSh call commands#MakeSh(<q-args>)
command! -nargs=+ Z call commands#Z(<q-args>)
command! -nargs=+ Lz call commands#Lz(<q-args>)
command! -nargs=1 Dc :all commands#Dc(<q-args>)
command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
