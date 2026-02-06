function operators#YankMarkdown(context = {}, type = '', onlyline = 0, includecolumn = 0) abort
  if a:type == ''
    let context = #{
          \ dot_command: v:false,
          \ extend_block: '',
          \ virtualedit: [&l:virtualedit, &g:virtualedit],
          \ only_line: a:onlyline,
          \ cursor_position: getpos("."),
          \ include_column: a:includecolumn,
          \ }
    let &operatorfunc = function('operators#YankMarkdown', [context])
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
    if a:context.only_line
      let commands = ''
    else
      let commands = #{
            \ line: "'[V']",
            \ char: "`[v`]",
            \ block: "`[\<C-V>`]",
            \ }[a:type]
    endif
    let [_, _, col, off] = getpos("']")
    if off != 0
      let vcol = getline("'[")->strpart(0, col + off)->strdisplaywidth()
      if vcol >= [line("'["), ']->virtcol() - 1
        let a:context.extend_block = '
      else
        let a:context.extend_block = vcol .. '|'
      endif
    endif
    if a:context.extend_block != ''
      let commands ..= 'oO' .. a:context.extend_block
    endif

    if a:type == 'line'
      redraw
    endif

    let commands ..= 'y'
    let l:register = v:register
    execute 'silent noautocmd keepjumps normal! ' .. commands
    let l:contents = @@
    let l:result = ''
    let l:idx = line('.')
    let l:file_path = expand('%:~')
    let l:ft = &filetype

    if a:context.only_line
      call setpos('.', a:context.cursor_position)
      let l:col = col('.')
      if a:context.include_column
        let l:result = '``` grep' .. "\n" .. l:file_path .. ':' .. l:idx .. ':' .. l:col .. ':' .. "\n" .. '```'
      else
        let l:result = '``` grep' .. "\n" .. l:file_path .. ':' .. l:idx .. ':' .. "\n" .. '```'
      endif
      echom l:file_path .. ':' .. l:idx
    else
      let l:result = '``` grep' .. "\n" .. l:file_path .. ':' .. l:idx .. ':1:' .. "\n" .. '```' .. "\n"
      let l:result ..= "\n" .. '``` ' .. l:ft .. "\n" .. l:contents
      " Ensure the code block closing is on its own line
      if l:contents[-1:] != "\n"
        let l:result ..= "\n"
      endif
      let l:result ..= '```'
    endif

    let @@ = l:result
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
    if a:context.only_line
      exe 'silent keepjumps normal! VPgg"' .. l:register .. 'yg_'
    else
      exe 'silent keepjumps normal! VPgg"' .. l:register .. 'yG'
    endif
    bd!

  finally
    call setpos("'<", save.visual_marks[0])
    call setpos("'>", save.visual_marks[1])
    let &clipboard = save.clipboard
    let &selection = save.selection
    let [&l:virtualedit, &g:virtualedit] = get(a:context.dot_command ? save : a:context, 'virtualedit')
    let a:context.dot_command = v:true
  endtry
endfunction
