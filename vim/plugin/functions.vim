function! GrepLine() abort
  return expand("%:~").":".line('.')
endfunction

function! GrepMarkdownVisual()
  let reg_save = @@
  if exists("@*")
    let reg_save2 = @*
  endif

  silent exe "normal gvy"
  let result = "`".expand("%:~").":".line('.')."`:\n\n```\n".@@."```"

  let @@ = reg_save
  if exists("@*")
    let @* = reg_save2
  endif

  return result
endfunction
