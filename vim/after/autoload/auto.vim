" Stand in for `system()` in Vim only, which writes `{input}` to a file in the
" session temp directory and so fails (`E484`) when the system clean up
" temporary files (most likely to happen if Vim has been running a long time).
" `job_start()` writes `a:text` on a pipe instead, so no temp file is
" involved. Delete this and call `system()` everywhere once Vim handles a
" reaped temp directory
function! auto#SystemPipe(cmd, text) abort
  " - `expand()` because a list `{command}` runs without a shell, so nothing
  "   else expands the `~` in `a:cmd`
  " - `'stoponexit': ''` because jobs are otherwise killed when Vim exits,
  "   which would drop a yank immediately followed by `:q`
  let l:job = job_start([expand(a:cmd)], {'in_io': 'pipe', 'out_io': 'null', 'err_io': 'null', 'stoponexit': ''})
  call ch_sendraw(l:job, a:text)
  " `ch_close_in()` sends the `EOF` that command (e.g., `pbcopy`, `tmux loadb
  " -`) wait for
  call ch_close_in(l:job)
endfunction

function! auto#MakeShebangFilesExecutable() abort
  if match(getline(1), '^\#!') == 0
    if match(getfperm(expand('%:p')), 'x') == -1
      !chmod +x "%"
    endif
  endif
endfunction
