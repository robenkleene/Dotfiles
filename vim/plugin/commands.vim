command! -nargs=+ Rg :call commands#Rg(<q-args>)
command! -nargs=+ Z :call commands#Z(<q-args>)
command! -nargs=1 Dc :call commands#Dc(<q-args>)
command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
