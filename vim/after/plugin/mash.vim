command! -nargs=+ -complete=shellcmd S call mash#Sh(1, <q-args>, 'enew')
command! -nargs=+ -complete=shellcmd System call mash#Sh(1, <q-args>, 'enew')
