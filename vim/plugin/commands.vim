command! -nargs=1 -bar Dc call commands#Dc(<q-args>)
command! -nargs=+ -complete=file_in_path Grep call commands#Make(<q-args>, "Grep")
command! -nargs=+ -complete=shellcmd Make call commands#Make(<q-args>, "Make")
command! -nargs=+ -bang -complete=shellcmd Args call commands#Args(<bang>0, <q-args>)
