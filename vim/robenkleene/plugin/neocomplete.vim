if !has('lua')
  finish
end

let g:neocomplete#enable_at_startup = 1

" Delay Before Popup Displays
let g:neocomplete#enable_cursor_hold_i = 1
let g:neocomplete#cursor_hold_i_time = 100

" Autoselect matches (don't have to use arrows)
let g:neocomplete#enable_auto_select = 1
