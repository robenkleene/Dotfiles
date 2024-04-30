function operators#YankGrep(context = {}, type = '') abort
  if a:type == ''
    let context = #{
          \ dot_command: v:false,
          \ extend_block: '',
          \ virtualedit: [&l:virtualedit, &g:virtualedit],
          \ }
    let &operatorfunc = function('operators#YankGrep', [context])
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

    " Workaround where visual line mode gets stuck on otherwise
    if a:type == 'line'
      redraw
    endif

    let commands ..= 'y'
    let l:register=v:register
    execute 'silent noautocmd keepjumps normal! ' .. commands
    let l:contents = @@
    let l:result = ''
    let l:idx = line('.')
      " `fnamemodify(expand("%"), ":~:.")` tries to get the relative path
    let l:file_path = fnamemodify(expand("%"), ":~:.")
    for l:line in split(l:contents, '\n')
      let l:result .= l:file_path.':'.l:idx.':'.l:line."\n"
      let l:idx += 1
    endfor

    " Use termporary buffer to force `YankTextPost` to trigger
    let @@ = l:result
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
    exe 'silent keepjumps normal! VPgg"'.l:register.'yG'
    bd!

  finally
    if l:register !=# '"'
      call setreg('"', save.register)
    endif
    call setpos("'<", save.visual_marks[0])
    call setpos("'>", save.visual_marks[1])
    let &clipboard = save.clipboard
    let &selection = save.selection
    let [&l:virtualedit, &g:virtualedit] = get(a:context.dot_command ? save : a:context, 'virtualedit')
    let a:context.dot_command = v:true
  endtry
endfunction

function operators#YankCodeBlock(context = {}, type = '') abort
  if a:type == ''
    let context = #{
          \ dot_command: v:false,
          \ extend_block: '',
          \ virtualedit: [&l:virtualedit, &g:virtualedit],
          \ }
    let &operatorfunc = function('operators#YankCodeBlock', [context])
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

    " Workaround where visual line mode gets stuck on otherwise
    if a:type == 'line'
      redraw
    endif

    let commands ..= 'y'
    let l:register=v:register
    execute 'silent noautocmd keepjumps normal! ' .. commands
    let l:contents = @@
    let l:result = ''
    let l:idx = line('.')
    " `fnamemodify(expand("%"), ":~:.")` tries to get the relative path
    let l:result = '`'.fnamemodify(expand("%"), ":~:.").':'.l:idx.'`:'."\n"
    let l:result .= '``` '.&filetype."\n"
    let l:result .= l:contents
    let l:result .= '```'

    " Use termporary buffer to force `YankTextPost` to trigger
    let @@ = l:result
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
    exe 'silent keepjumps normal! VPgg"'.l:register.'yG'
    bd!

  finally
    if l:register !=# '"'
      call setreg('"', save.register)
    endif
    call setpos("'<", save.visual_marks[0])
    call setpos("'>", save.visual_marks[1])
    let &clipboard = save.clipboard
    let &selection = save.selection
    let [&l:virtualedit, &g:virtualedit] = get(a:context.dot_command ? save : a:context, 'virtualedit')
    let a:context.dot_command = v:true
  endtry
endfunction
