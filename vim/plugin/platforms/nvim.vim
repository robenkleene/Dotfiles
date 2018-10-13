" NeoVim Only

if !has('nvim')
  finish
endif

function! s:OpenTTerminal()
  " Only remap `<Esc>` in this buffer so it doesn't interfere
  " with commands that spawn terminals like `fzf`
  tabnew
  terminal zsh
  tnoremap <buffer> <Esc> <C-\><C-n>
endfunction
function! s:OpenTerminal()
  " Only remap `<Esc>` in this buffer so it doesn't interfere
  " with commands that spawn terminals like `fzf`
  split
  terminal zsh
  tnoremap <buffer> <Esc> <C-\><C-n>
endfunction
function! s:OpenVTerminal()
  " Only remap `<Esc>` in this buffer so it doesn't interfere
  " with commands that spawn terminals like `fzf`
  vsplit
  terminal zsh
  " Make escape exit insert mode
  tnoremap <buffer> <Esc> <C-\><C-n>
endfunction
command! TigStatus call <SID>TigStatus()
function! s:TigStatus() abort
  tabnew
  execute 'terminal EDITOR=nvim_edit tig status +3'
  " Make escape exit insert mode
  " tnoremap <buffer> <Esc> <C-\><C-n>
endfunction

nnoremap <leader>tt :call <SID>OpenTerminal()<CR>
nnoremap <leader>ts :call <SID>TigStatus()<CR>
" nnoremap <leader>tv :call <SID>OpenVTerminal()<CR>
" nnoremap <leader>tt :call <SID>OpenTTerminal()<CR>
command! Term :call <SID>OpenTerminal()
command! VTerm :call <SID>OpenVTerminal()
command! TTerm :call <SID>OpenTTerminal()
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
