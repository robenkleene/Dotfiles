command! -range -nargs=+ -complete=command Part silent <line1>,<line2>call commands#Part(<q-args>)
command! -range -nargs=+ -complete=shellcmd PartSh <line1>,<line2>call commands#Part('!'.<q-args>)
command! -range PartNew silent <line1>,<line2>call commands#PartNew("new")
command! -range PartVnew silent <line1>,<line2>call commands#PartNew("vnew")
command! -range PartEnew silent <line1>,<line2>call commands#PartNew("enew")
command! -range PartTabnew silent <line1>,<line2>call commands#PartNew("tabnew")
command! -range PartTabedit silent <line1>,<line2>call commands#PartNew("tabnew")

command! -nargs=+ -bang -complete=shellcmd GrepSh call commands#GrepSh(<bang>0, <q-args>)
command! -nargs=+ -complete=shellcmd ArgsSh call commands#ArgsSh(<q-args>)
command! -nargs=+ -bang -complete=shellcmd MakeSh call commands#MakeSh(<bang>0, <q-args>)
command! -nargs=+ -complete=shellcmd NewSh call commands#NewSh(<q-args>)
command! -nargs=+ -complete=shellcmd VnewSh call commands#VnewSh(<q-args>)
command! -nargs=+ -complete=shellcmd EnewSh call commands#EnewSh(<q-args>)
command! -nargs=+ -complete=shellcmd TabnewSh call commands#TabnewSh(<q-args>)
command! -nargs=+ -complete=shellcmd TabeditSh call commands#TabnewSh(<q-args>)

command! -nargs=+ -complete=shellcmd Fd call commands#Fd(<q-args>)
command! -nargs=+ -bang -complete=shellcmd Rg call commands#Rg(<bang>0, <q-args>)
command! -nargs=+ Z call commands#Zlcd(<q-args>)
command! -nargs=+ Zcd call commands#Zcd(<q-args>)
command! -nargs=+ Zlcd call commands#Zlcd(<q-args>)
command! -nargs=+ Ztcd call commands#Ztcd(<q-args>)

command! -nargs=1 Dc call commands#Dc(<q-args>)

command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
