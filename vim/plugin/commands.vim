command! -nargs=1 -bar Dc call commands#Dc(<q-args>)
command! -nargs=+ -complete=file_in_path -bar Rg call commands#Rg(<f-args>)
command! -nargs=+ -bang -complete=shellcmd Fd call commands#Fd(<bang>0, <q-args>)
