function! operators#GrepYank(type, ...) abort
  " `@@` is an alias for `@"`, the unnamed register
  let sel_save = &selection
  " From `h :map-operator`: The 'selection' option is temporarily set to
  " "inclusive" to be able to yank exactly the right text by using Visual mode
  " from the '[ to the '] mark.
  let &selection = "inclusive"
  let reg_save = @@
  if exists("@*")
    " Protect the `*` register
    let reg_save2 = @*
  endif
  if exists("@+")
    " Protect the `*` register
    let reg_save3 = @+
  endif
  if a:0
    " Visual
    silent exe "normal! gvy"
  elseif a:type == 'line'
    " Line
    silent exe "normal! '[V']y"
  else
    " Character
    silent exe "normal! `[v`]y"
  endif

  let result = expand("%:~").":".line('.').":\n".@@
  echom "let @".v:register." = result"
  exe "let @".v:register." = result"


  let &selection = sel_save
  if v:register != '"'
    let @@ = reg_save
  endif
  if exists("@*")
    let @* = reg_save2
  endif
  if exists("@+")
    let @+ = reg_save3
  endif
endfunction
