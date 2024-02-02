setlocal spell
let g:markdown_folding = 1

setlocal colorcolumn=""
setlocal wrap

let g:markdown_fenced_languages = [
      \'bash=sh',
      \'c',
      \'cpp',
      \'html',
      \'javascript',
      \'js=javascript',
      \'kotlin',
      \'lua',
      \'python',
      \'ruby',
      \'rust',
      \'vim'
      \]

function! s:InsertTitle()
    let l:filename = expand('%:p')
    let l:title = system('~/.bin/md_title ' . shellescape(l:filename) . ' | grep .')
    return l:title
endfunction
iabbrev <buffer> :title: <C-R>=<SID>InsertTitle()<CR>
