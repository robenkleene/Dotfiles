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

augroup safepaste
  autocmd!
  autocmd FocusGained * let @" = system('~/.bin/safepaste')
augroup END
let @" = system('~/.bin/safepaste')
