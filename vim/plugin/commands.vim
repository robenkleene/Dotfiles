command! -range -nargs=+ -complete=command P silent <line1>,<line2>call commands#P(<q-args>)
command! -range -nargs=+ -complete=shellcmd Psh <line1>,<line2>call commands#P('!'.<q-args>)
command! -range New silent <line1>,<line2>call commands#New("new")
command! -range Vnew silent <line1>,<line2>call commands#New("vnew")
command! -range Enew silent <line1>,<line2>call commands#New("enew")
command! -range Tabnew silent <line1>,<line2>call commands#New("tabnew")
command! -range Tabe silent <line1>,<line2>call commands#New("tabnew")
command! -range Tabedit silent <line1>,<line2>call commands#New("tabnew")

command! -nargs=+ -bang -complete=shellcmd GrepSh call commands#GrepSh(<bang>0, <q-args>)
command! -nargs=+ -complete=shellcmd ArgsSh call commands#ArgsSh(<q-args>)
command! -nargs=+ -bang -complete=shellcmd MakeSh call commands#MakeSh(<bang>0, <q-args>)
command! -nargs=+ -complete=shellcmd NewSh call commands#Nsh(<q-args>)
command! -nargs=+ -complete=shellcmd VNewSh call commands#Vsh(<q-args>)
command! -nargs=+ -complete=shellcmd ENewSh call commands#Esh(<q-args>)
command! -nargs=+ -complete=shellcmd TabSh call commands#Tsh(<q-args>)
" Shorthand
command! -nargs=+ -bang -complete=shellcmd Gsh call commands#GrepSh(<bang>0, <q-args>)
command! -nargs=+ -complete=shellcmd Ash call commands#ArgsSh(<q-args>)
command! -nargs=+ -bang -complete=shellcmd Msh call commands#MakeSh(<bang>0, <q-args>)
command! -nargs=+ -complete=shellcmd Nsh call commands#Nsh(<q-args>)
command! -nargs=+ -complete=shellcmd Vsh call commands#Vsh(<q-args>)
command! -nargs=+ -complete=shellcmd Esh call commands#Esh(<q-args>)
command! -nargs=+ -complete=shellcmd Tsh call commands#Tsh(<q-args>)

command! -nargs=+ Zcd call commands#Zcd(<q-args>)
command! -nargs=+ Zlcd call commands#Zlcd(<q-args>)
command! -nargs=+ Ztcd call commands#Ztcd(<q-args>)

command! -nargs=1 Dc :all commands#Dc(<q-args>)

command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
