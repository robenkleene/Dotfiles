command! -range -nargs=+ -complete=command P silent <line1>,<line2>call commands#P(<q-args>)
command! -range -nargs=+ -complete=shellcmd Psh <line1>,<line2>call commands#P('!'.<q-args>)
command! -range Pnew silent <line1>,<line2>call commands#Pnew("new")
command! -range Pvnew silent <line1>,<line2>call commands#Pnew("vnew")
command! -range Penew silent <line1>,<line2>call commands#Pnew("enew")
command! -range Ptabnew silent <line1>,<line2>call commands#Pnew("tabnew")
command! -range Ptabe silent <line1>,<line2>call commands#Pnew("tabnew")
command! -range Ptabedit silent <line1>,<line2>call commands#Pnew("tabnew")

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

command! -nargs=+ -complete=shellcmd F call commands#Fd(<q-args>)
command! -nargs=+ -bang -complete=shellcmd G call commands#Rg(<bang>0, <q-args>)
command! -nargs=+ Zcd call commands#Zcd(<q-args>)
command! -nargs=+ Zlcd call commands#Zlcd(<q-args>)
command! -nargs=+ Ztcd call commands#Ztcd(<q-args>)

command! -nargs=1 Dc call commands#Dc(<q-args>)

command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
