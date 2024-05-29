command! -range -nargs=* -complete=command P silent <line1>,<line2>call commands#Part(<q-args>)
command! -range -nargs=+ -complete=shellcmd Psh <line1>,<line2>call commands#Part('!'.<q-args>)
command! -nargs=+ -bang -complete=shellcmd Gsh call commands#GrepSh(<bang>0, <q-args>)
command! -nargs=+ -complete=shellcmd Ash call commands#ArgsSh(<q-args>)
command! -nargs=+ -bang -complete=shellcmd Msh call commands#MakeSh(<bang>0, <q-args>)
command! -nargs=+ -bang -complete=shellcmd Sh call commands#Sh(<bang>0, <q-args>)

command! -nargs=+ -complete=shellcmd Fd call commands#Fd(<q-args>)
command! -nargs=+ -bang -complete=shellcmd Rg call commands#Rg(<bang>0, <q-args>)
command! -nargs=+ -bar Z call commands#Zlcd(<q-args>)
command! -nargs=+ -bar Zcd call commands#Zcd(<q-args>)
command! -nargs=+ -bar Ztcd call commands#Ztcd(<q-args>)

command! -nargs=1 -bar Dc call commands#Dc(<q-args>)

command! -bar Tput put =system('~/.bin/safepaste')

command! -nargs=1 -bar -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>

command! -nargs=1 Ggrep call commands#Ggrep(<q-args>)
