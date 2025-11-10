if did_filetype()
  finish
endif

" if getline(1) =~ '^o  [a-z0-9]\{10}' && getline(2) =~ '^╷$'
"   setfiletype hg
" endif

" Without this, `hg show | vim -` will be unstyled
if getline(1) =~ '^changeset:' &&
      \ getline(2) =~ '^parent:' &&
      \ getline(3) =~ '^user:' &&
      \ getline(4) =~ '^date:'
  setfiletype diff
endif
