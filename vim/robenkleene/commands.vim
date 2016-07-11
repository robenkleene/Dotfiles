" Colors
if exists("*synstack")
  " Syntax Groups
  function! s:SyntaxGroups()
    return join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'))
  endfunc
  " Echo Syntax Group
  command! EchoSyntaxGroups :echo <SID>SyntaxGroups()
  " Yank Syntax Group
  command! YankSyntaxGroups :let @" = <SID>SyntaxGroups()|:let @+ = @"|:echo @"

  " Syntax Colors
  function! s:SyntaxColors()
    let syntaxcolors = 'fg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg")
    let syntaxcolors .= ' fg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")
    let syntaxcolors .= ' bg:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg")
    let syntaxcolors .= ' bg#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")
    let syntaxcolors .= ' sp:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp")
    let syntaxcolors .= ' sp#:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"sp#")
    let syntaxcolors .= ' italic:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"italic")
    let syntaxcolors .= ' reverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"reverse")
    let syntaxcolors .= ' inverse:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"inverse")
    let syntaxcolors .= ' standout:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"standout")
    let syntaxcolors .= ' underline:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"underline")
    let syntaxcolors .= ' undercurl:' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"undercurl")
    return syntaxcolors
  endfunc
  " Echo Syntax Colors
  command! EchoSyntaxColors :echo <SID>SyntaxColors()
endif
" Also remember `:XtermColorTable`
command! RunHighlightTest :source $VIMRUNTIME/syntax/hitest.vim
command! RunColorTest :source $VIMRUNTIME/syntax/colortest.vim

" Quit and save contents of buffer to the clipboard
command! -bang Q
      \ execute "%w !pbcopy" |
      \ if <bang>1 |
      \   execute "q" |
      \ else |
      \   execute "q<bang>" |
      \ endif

" Quit and save session
command! -bang Qs
      \ execute "SaveSession" |
      \ if <bang>1 |
      \   execute "qa!" |
      \ else |
      \   execute "qa" |
      \ endif

" Make the current buffer a grep buffer
command! GrepBuffer :call <SID>GrepBuffer()
function! s:GrepBuffer()
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  if line('$') == 1
    " Don't show the quickfix list if there's exactly one match
    execute "cbuffer"
  else
    " execute "cbuffer | cw"
    execute "cbuffer | copen 20"
  endif
endfunction


" This will be built-in to Vim soon:
" [patch 7.4.858 · vim/vim@aa23b37](https://github.com/vim/vim/commit/aa23b379421aa214e6543b06c974594a25799b09)
" Delete this when that version of Vim is live
" Populate the args list from the quickfix list
" Note that a patch was submitted that might make this feature
" command unnecessary in a future version of Vim
" Source
" http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim
" Patch
" https://groups.google.com/forum/#!msg/vim_dev/dfyt-G6SMec/_6h8pDUpeZMJ
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" Save and Restore Session State
command! SaveSession :mksession! ~/.vim/vim_session
command! RestoreSession :source ~/.vim/vim_session

