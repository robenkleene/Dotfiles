if (exists("b:did_ftplugin"))
    finish
endif
let b:did_ftplugin = 1

setlocal nomodeline formatoptions-=croq formatoptions+=tl
setlocal foldmethod=expr
setlocal foldexpr=DiffFoldLevel()
setlocal foldcolumn=3

function! DiffFoldLevel()
    let l:line=getline(v:lnum)

    if l:line =~# '^\(diff\|Index\)'     " file
        return '>1'
    elseif l:line =~# '^\(@@\|\d\)'  " hunk
        return '>2'
    elseif l:line =~# '^\*\*\* \d\+,\d\+ \*\*\*\*$' " context: file1
        return '>2'
    elseif l:line =~# '^--- \d\+,\d\+ ----$'     " context: file2
        return '>2'
    else
        return '='
    endif
endfunction

