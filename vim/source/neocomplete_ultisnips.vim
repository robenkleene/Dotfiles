" default value, just set once
" let g:ulti_expand_res = 0 

function! s:complete_expand()
    return neocomplete#close_popup() . <SID>expand_snippet_discard_result()
endfunction

function! s:expand_snippet_discard_result()
    call UltiSnips#ExpandSnippet()
    return ''
endfunction

" Not sure why these don't work
" inoremap <expr><TAB> pumvisible() ? <SID>complete_expand() : UltiSnips#ExpandSnippet()
" inoremap <expr><CR> pumvisible() ? <SID>complete_expand() : "\<CR>"

function! s:tab_complete()
    return pumvisible() ? <SID>complete_expand() : UltiSnips#ExpandSnippetOrJump()
endfunction

function! s:return_complete()
    return pumvisible() ? <SID>complete_expand() : "\<CR>"
endfunction

inoremap <silent> <TAB> <C-r>=<SID>tab_complete()<CR>
inoremap <silent> <CR> <C-r>=<SID>return_complete()<CR>
