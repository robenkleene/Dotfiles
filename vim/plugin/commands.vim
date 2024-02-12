command! -range -nargs=+ -com=command P silent <line1>,<line2>call commands#P(<q-args>)
command! -nargs=+ Rg :call commands#Rg(<q-args>)
command! -nargs=+ Fd :call commands#Fd(<q-args>)
command! -nargs=+ Z :call commands#Z(<q-args>)
command! -nargs=+ Lz :call commands#Lz(<q-args>)
command! -nargs=1 Dc :call commands#Dc(<q-args>)
command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
