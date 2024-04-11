set rtp+=$HOMEBREW_DIR/opt/fzf

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>o :History<CR>
nnoremap <silent> <leader>t :BTags<CR>

nnoremap <silent> <leader>c :call fzf_quickfix#run()<CR>

function! s:error_type(type, number) abort
  if a:type ==? 'W'
    let l:msg = ' warning'
  elseif a:type ==? 'I'
    let l:msg = ' info'
  elseif a:type ==? 'E' || (a:type ==# "\0" && a:number > 0)
    let l:msg = ' error'
  elseif a:type ==# "\0" || a:type ==# "\1"
    let l:msg = ''
  else
    let l:msg = ' ' . a:type
  endif

  if a:number <= 0
    return l:msg
  endif

  return printf('%s %3d', l:msg, a:number)
endfunction

function! s:format_error(item) abort
  return (a:item.bufnr ? bufname(a:item.bufnr) : '')
        \ . '|' . (a:item.lnum  ? a:item.lnum : '')
        \ . (a:item.col ? ' col ' . a:item.col : '')
        \ . s:error_type(a:item.type, a:item.nr)
        \ . '|' . substitute(a:item.text, '\v^\s*', ' ', '')
endfunction

function! s:get_quickfix_errors() abort
  return map(getqflist(), 's:format_error(v:val)')
endfunction

function! s:error_handler(err) abort
  let l:match = matchlist(a:err, '\v^([^|]*)\|(\d+)?%(\scol\s(\d+))?.*\|')[1:3]
  if empty(l:match) || empty(l:match[0])
    return
  endif

  if empty(l:match[1]) && (bufnr(l:match[0]) == bufnr('%'))
    return
  endif

  let l:line_number = empty(l:match[1]) ? 1 : str2nr(l:match[1])
  let l:col_number = empty(l:match[2]) ? 1 : str2nr(l:match[2])

  execute 'buffer' bufnr(l:match[0])
  mark '
  call cursor(l:line_number, l:col_number)
  normal! zvzz
endfunction

function! fzf_quickfix#run() abort
  let l:opts = {
        \ 'source': s:get_quickfix_errors(),
        \ 'sink': function('s:error_handler'),
        \ 'options': '--prompt="Error> "'
        \ }
  call fzf#run(fzf#wrap(l:opts))
endfunction
