if did_filetype()	" filetype already set..
  finish		" ..don't do these checks
endif

" if getline(1) =~ '^o  [a-z0-9]\{10}' && getline(2) =~ '^╷$'
"   setfiletype hg
" endif
