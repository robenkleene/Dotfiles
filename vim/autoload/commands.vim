" Make the current buffer a grep buffer
function! commands#GrepBuffer() abort
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  " `cbuffer`: Convert to `quickfix`
  " `bprevious`: Go back to grep input
  " `bdelete`: Delete the grep buffer
  if line('$') == 1
    " Don't show the quickfix list if there's exactly one match
    execute "cbuffer | bprevious | bdelete"
  else
    execute "cbuffer | bprevious | bdelete | cw | wincmd k"
  endif
endfunction

" Save & Restore Sessions
function! commands#QuitSaveSession() abort
  SessionSave
  qa
endfunction

" Go to `git` root
function! commands#Gcd() abort
  let l:git_root = system('git rev-parse --show-toplevel | tr -d "\n"')
  if v:shell_error == 0
    execute 'lcd '.fnameescape(l:git_root)
  else
    echo "Not in a git respository."
  endif
endfunction

" `rg`
function! commands#Rg(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
  execute "grep " . a:terms
  let &grepprg = l:original_grepprg
endfunction

" `rg` & `tmux`
function! commands#Atm(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=tmux-paths-rg
  execute "grep " . a:terms
  let &grepprg = l:original_grepprg
endfunction
