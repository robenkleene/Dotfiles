if did_filetype()
  finish
endif

" Without this, `hg show | vim -` will be unstyled
if getline(1) =~ '^changeset:' &&
      \ getline(2) =~ '^parent:' &&
      \ getline(3) =~ '^user:' &&
      \ getline(4) =~ '^date:'
  setfiletype diff
endif
