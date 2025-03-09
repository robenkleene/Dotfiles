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

" function! s:MarkdownOpenLink()
"   let word = expand('<cWORD>')
"   let match = matchstr(word, '(\zs[^()]*\ze)')
"   if !empty(match)
"     execute 'Open' match
"   else
"     normal! gx
"   endif
" endfunction
" nnoremap <buffer> gx :call <SID>MarkdownOpenLink()<CR>
