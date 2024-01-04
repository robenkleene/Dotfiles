function! GrepLine() abort
  return expand("%:p").":".line('.')
endfunction

function! GrepMarkdownVisual()

  let reg_save = @@
  if exists("@*")
    let reg_save2 = @*
  endif

  silent exe "normal gvy"
  let result = "`".expand("%:p").":".line('.')."`:\n\n```\n".@@."```"

  let @@ = reg_save
  if exists("@*")
    let @* = reg_save2
  endif

  return result
endfunction
