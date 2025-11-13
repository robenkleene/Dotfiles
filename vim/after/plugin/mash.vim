command! -nargs=+ -bang -complete=shellcmd S call mash#Sh(<bang>0, <q-args>, 'enew')
