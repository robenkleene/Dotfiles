setlocal spell
let g:markdown_folding = 1

setlocal colorcolumn=""
setlocal wrap

function! s:InsertTitle()
    let l:filename = expand('%:p')
    let l:title = system('~/.bin/md_title ' . shellescape(l:filename) . ' | grep .')
    return l:title
endfunction
iabbrev <buffer> :title: <C-R>=<SID>InsertTitle()<CR>
