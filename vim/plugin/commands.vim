command! -nargs=1 -bar Dc call commands#Dc(<q-args>)
command! -nargs=+ Rg ShGrep rg <args>
command! -nargs=+ Fd ShArgs fd <args>
