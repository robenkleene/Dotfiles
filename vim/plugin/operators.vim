nnoremap <expr> <localleader>yg GrepYank()
xnoremap <expr> <localleader>yg GrepYank()
nnoremap <expr> <localleader>yg<localleader>yg GrepYank() .. '_'

function GrepYank(context = {}, type = '') abort
  if a:type == ''
    let context = #{
          \ dot_command: v:false,
          \ extend_block: '',
          \ virtualedit: [&l:virtualedit, &g:virtualedit],
          \ }
    let &operatorfunc = function('GrepYank', [context])
    set virtualedit=block
    return 'g@'
  endif

  let save = #{
        \ clipboard: &clipboard,
        \ selection: &selection,
        \ virtualedit: [&l:virtualedit, &g:virtualedit],
        \ register: getreginfo('"'),
        \ visual_marks: [getpos("'<"), getpos("'>")],
        \ }

  try
    set clipboard= selection=inclusive virtualedit=
    let commands = #{
          \ line: "'[V']",
          \ char: "`[v`]",
          \ block: "`[\<C-V>`]",
          \ }[a:type]
    let [_, _, col, off] = getpos("']")
    if off != 0
      let vcol = getline("'[")->strpart(0, col + off)->strdisplaywidth()
      if vcol >= [line("'["), '$']->virtcol() - 1
        let a:context.extend_block = '$'
      else
        let a:context.extend_block = vcol .. '|'
      endif
    endif
    if a:context.extend_block != ''
      let commands ..= 'oO' .. a:context.extend_block
    endif
    let commands ..= '"' .. v:register .. 'y'
    execute 'silent noautocmd keepjumps normal! ' .. commands
    let result = expand("%:~").":".line('.').":\n".@@
    exe "let @".v:register." = result"
    if v:register == '"'
      let save.register = result
    endif
  finally
    call setreg('"', save.register)
    call setpos("'<", save.visual_marks[0])
    call setpos("'>", save.visual_marks[1])
    let &clipboard = save.clipboard
    let &selection = save.selection
    let [&l:virtualedit, &g:virtualedit] = get(a:context.dot_command ? save : a:context, 'virtualedit')
    let a:context.dot_command = v:true
  endtry
endfunction
