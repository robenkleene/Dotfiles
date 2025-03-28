function! commands#Ztcd(terms) abort
  call commands#Zcmd("tcd", a:terms)
endfunction

function! commands#Zlcd(terms) abort
  call commands#Zcmd("lcd", a:terms)
endfunction

function! commands#Zcd(terms) abort
  call commands#Zcmd("cd", a:terms)
endfunction

function! commands#Zcmd(cd, terms) abort
  let l:result = system('zoxide query ' . a:terms)
  if v:shell_error == 1
      echo "No match found"
      return
  endif
  execute a:cd." ".l:result
  pwd
endfunction
