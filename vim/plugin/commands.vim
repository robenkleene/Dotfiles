command! -nargs=1 -bar Dc call commands#Dc(<q-args>)
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr commands#Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr commands#Grep(<f-args>)
command! -nargs=+ -bang -complete=shellcmd Find call commands#Find(<bang>0, 'fd '.<q-args>)
