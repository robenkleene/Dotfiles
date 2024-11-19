setlocal spell
let g:markdown_folding = 1
" Setting `g:markdown_folding` seems to force folds, so set this so that
" Markdown files don't start folded
set foldlevel=99

setlocal colorcolumn=""
setlocal wrap
setlocal textwidth=0

let g:markdown_fenced_languages = [
      \'bash=sh',
      \'c',
      \'cpp',
      \'diff',
      \'html',
      \'java',
      \'javascript',
      \'js=javascript',
      \'json',
      \'lua',
      \'python',
      \'ruby',
      \'rust',
      \'vim'
      \]
      " Causing an error on exit in Neovim that `syntax/kotlin.vim` can't be
      " found. Probably need to install a plugin?
      " \'kotlin',

function! s:InsertTitle()
    let l:filename = expand('%:p')
    let l:title = system('~/.bin/md_title ' . shellescape(l:filename) . ' | grep .')
    return l:title
endfunction
iabbrev <buffer> :title: <C-R>=<SID>InsertTitle()<CR>
