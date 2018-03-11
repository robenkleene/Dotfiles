" Check for snippets from only one location and always edit snippets with
" `UltiSnipsEdit` at that location
" Note that the documentation says that this should be a single value rather
" than an array, but it only works if it's an array.
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
" Note that this only works for tab stops before the last `$0` tab stop this
" is because UltiSnips exits after reaching the last tab stop.
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="context"

" Snippets
nnoremap <leader>os :UltiSnipsEdit<CR>

" Use `<A-s>` to complete snippets in templates
inoremap <silent> <A-s> <c-r>=<SID>ulti_complete()<cr>
function! s:ulti_complete() abort
    if empty(UltiSnips#SnippetsInCurrentScope(1))
        return ''
    endif
    let word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
    let contain_word = 'stridx(v:val, word_to_complete)>=0'
    let candidates = map(filter(keys(g:current_ulti_dict_info), contain_word),
                   \  "{
                   \      'word': v:val,
                   \      'menu': '[snip] '. g:current_ulti_dict_info[v:val]['description'],
                   \      'dup' : 1,
                   \   }")
    let from_where = col('.') - len(word_to_complete)
    if !empty(candidates)
        call complete(from_where, candidates)
    endif
    return ''
endfunction
