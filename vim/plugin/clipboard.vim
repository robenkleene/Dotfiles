if exists('##TextYankPost')==1
  augroup safecopy
    autocmd!
    autocmd TextYankPost * silent! call system('~/.bin/safecopy',join(v:event["regcontents"],"\n"))
  augroup END
else
  augroup safecopy
    autocmd!
    autocmd FocusLost *  silent! call system('~/.bin/safecopy',@")
  augroup END
endif

if $TMUX==''
  finish
endif

let s:lastbname=""

func! s:TmuxBufferName()
  let l:list = systemlist('tmux list-buffers -F"#{buffer_name}"')
  if len(l:list)==0
    return ""
  else
    return l:list[0]
  endif
endfunc

func! s:TmuxBuffer()
  return system('tmux show-buffer')
endfunc

func! s:update_from_tmux()
  let buffer_name = s:TmuxBufferName()
  if s:lastbname != buffer_name
    let @" = s:TmuxBuffer()
  endif
  let s:lastbname=s:TmuxBufferName()
endfunc

if exists('##TextYankPost')==1
  augroup vimtmuxclipboard
    autocmd!
    autocmd FocusLost * call s:update_from_tmux()
    autocmd FocusGained * call s:update_from_tmux()
  augroup END
  let @" = s:TmuxBuffer()
else
  augroup vimtmuxclipboard
    autocmd!
    autocmd FocusGained * let @" = s:TmuxBuffer()
  augroup END
  let @" = s:TmuxBuffer()
endif
