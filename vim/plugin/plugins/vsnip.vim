let g:vsnip_snippet_dir = '~/.config/Code/User/snippets'

imap <expr> <Tab>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.sh = ['shellscript']
let g:vsnip_filetypes.zsh = ['sh']

function! VsnipSnippetToCompletion(snippet)
  return {
        \ 'word': a:snippet.trigger,
        \ 'menu': 'Snippet',
        \ 'info': join(a:snippet.dscr, "\n") . "\n" . join(vsnip#snippet#docstring(a:snippet), "\n"),
        \ 'dup': 1,
        \ 'user_data': 'vsnip'
        \ }
endfunction

function! VsnipSnippetFilter(line_to_cursor, base) abort
  return {snippet -> !vsnip#snippet#hidden(snippet) && vsnip#util#starts_with(vsnip#snippet#trigger(snippet), a:base)}
endfunction

function! VsnipCompleteFunc(findstart, base) abort
  let line = getline('.')
  let col = col('.') - 1
  let line_to_cursor = line[:col]

  if a:findstart
    return match(line_to_cursor, '\k*$')
  endif

  " Retrieve snippets for the current filetype and all
  let snippets = vsnip#get_complete_items(&filetype) + vsnip#get_complete_items('all')
  let snippets = filter(snippets, VsnipSnippetFilter(line_to_cursor, a:base))

  " Transform snippets into completion items
  let snippets = map(snippets, 'VsnipSnippetToCompletion(v:val)')

  " Sort snippets by word
  call sort(snippets, {s1, s2 -> s1['word'] < s2['word'] ? -1 : 1})

  return snippets
endfunction

set completefunc=VsnipCompleteFunc
