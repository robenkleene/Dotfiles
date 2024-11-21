command! -nargs=+ -bar Z call commands#Zlcd(<q-args>)
command! -nargs=+ -bar Zcd call commands#Zcd(<q-args>)
command! -nargs=+ -bar Ztcd call commands#Ztcd(<q-args>)

command! -nargs=1 -bar Dc call commands#Dc(<q-args>)

command! -nargs=1 Ggrep call commands#Ggrep(<q-args>)
command! -nargs=1 Gg call commands#Ggrep(<q-args>)
