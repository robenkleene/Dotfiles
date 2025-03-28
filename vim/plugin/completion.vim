" Use all open buffers for completion, this makes using `CTRL-X_CTRL-L`
" completion work better for adding logging to multiple buffers at once
set complete+=b
" Setting this two high is annoying with autocomplete
set pumheight=10
" Complete to longest match and show a menu, matching the typical `zsh` setup.
" Note this doesn't seem to always work, e.g., `:tag <term><tab>` doesn't seem
" to complete to the longest common string. But you can test the setting is
" correct by going to a directory with matching filenames and trying `:e
" <term><tab>`
set wildmode=longest:full,full
" This is causing an issue where the text to complete gets deleted
" It also sometimes just looks ugly like the text for the full match shows for
" an instant and then gets deleted
" Turn this on, it makes exploring an API with completion a lot easier,
" without it trigger completion will select an item and enter it in the
" buffer, so the completion options can't be narrowed again after starting a
" completion
 set completeopt+=longest
 " This shows a popup split which has somewhat useful information but is very
 " disconcerting because it moves the text of the current split as well
 set completeopt-=preview
" Use a vertical wildmenu
set wildoptions=pum

" Automatically close the completion preview
augroup completion_preview
  autocmd!
  autocmd CompleteDone * pclose
augroup END
