command! -nargs=+ -bang -complete=shellcmd Find call mash#EditSh(<bang>0, 'fd '.<q-args>, 'args')
