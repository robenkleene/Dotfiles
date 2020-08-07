" Suppress a `DeprecationWarning` as documented here
" https://github.com/SirVer/ultisnips/issues/996
if has('python3')
  silent! python3 1
endif

" Check for snippets from only one location and always edit snippets with
" `UltiSnipsEdit` at that location
" Note that the documentation says that this should be a single value rather
" than an array, but it only works if it's an array.
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
" " Note that this only works for tab stops before the last `$0` tab stop this
" " is because UltiSnips exits after reaching the last tab stop.
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="context"

" Snippets
" nnoremap <leader>os :UltiSnipsEdit<CR>

" Snippet Autocomplete
" The `<C-x><C-t>` binding matches other complete bindings (like `<C-x><C-n>`)
" And the complement of the built in `i_CTRL-T` command is already overriden
" by `RSI.vim`. Mnemonic is "text".
" Disabling this because emacs bindings use `<C-t>` for transpose characters
" inoremap <silent> <C-t> <c-r>=<SID>ulti_complete()<cr>
" inoremap <silent> <C-x><C-s> <c-r>=<SID>ulti_complete()<cr>
" function! s:ulti_complete() abort
"     if empty(UltiSnips#SnippetsInCurrentScope(1))
"         return ''
"     endif
"     let word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
"     let contain_word = 'stridx(v:val, word_to_complete)>=0'
"     let candidates = map(filter(keys(g:current_ulti_dict_info), contain_word),
"                    \  "{
"                    \      'word': v:val,
"                    \      'menu': '[snip] '. g:current_ulti_dict_info[v:val]['description'],
"                    \      'dup' : 1,
"                    \   }")
"     let from_where = col('.') - len(word_to_complete)
"     if !empty(candidates)
"         call complete(from_where, candidates)
"     endif
"     return ''
" endfunction

" Use `UltiSnips` for built-in completion with `<C-x C-u>`
set completefunc=ListSnippets
function! ListSnippets(findstart, base) abort
  if empty(UltiSnips#SnippetsInCurrentScope(1))
    return ''
  endif

  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && (line[start - 1] =~ '\a')
      let start -= 1
    endwhile
    return start
  else
    " find classes matching "a:base"
    let res = []
    for m in keys(g:current_ulti_dict_info)
      if m =~ a:base
        let n = {
              \ 'word': m,
              \ 'menu': '[snip] '. g:current_ulti_dict_info[m]['description']
              \ }
        call add(res, n)
      endif
    endfor
    return res
  endif
endfunction
