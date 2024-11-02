command! -nargs=+ -bar Z call commands#Zlcd(<q-args>)
command! -nargs=+ -bar Zcd call commands#Zcd(<q-args>)
command! -nargs=+ -bar Ztcd call commands#Ztcd(<q-args>)

command! -nargs=1 -bar Dc call commands#Dc(<q-args>)

command! -nargs=1 -bar -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>

command! -nargs=1 Ggrep call commands#Ggrep(<q-args>)
command! -nargs=1 Gg call commands#Ggrep(<q-args>)
