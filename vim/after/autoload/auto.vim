" Stand in for `system()` in Vim only, which writes `{input}` to a file in the
" session temp directory and so fails (`E484`) when the system clean up
" temporary files (most likely to happen if Vim has been running a long time).
" `job_start()` writes `a:text` on a pipe instead, so no temp file is
" involved. Delete this and call `system()` everywhere once Vim handles a
" reaped temp directory
function! auto#SystemPipe(cmd, text) abort
  " - `expand()` because a list `{command}` runs without a shell, so nothing
  "   else expands the `~` in `a:cmd`
  " - `'stoponexit': ''` because jobs are otherwise killed when Vim exits,
  "   which would drop a yank immediately followed by `:q`
  let l:job = job_start([expand(a:cmd)], {'in_io': 'pipe', 'out_io': 'null', 'err_io': 'null', 'stoponexit': ''})
  call ch_sendraw(l:job, a:text)
  " `ch_close_in()` sends the `EOF` that a command reading `stdin` (e.g., `tmux
  " loadb -`) waits for
  call ch_close_in(l:job)
endfunction

function! auto#MakeShebangFilesExecutable() abort
  if match(getline(1), '^\#!') == 0
    if match(getfperm(expand('%:p')), 'x') == -1
      !chmod +x "%"
    endif
  endif
endfunction

function! auto#HighlightInactiveWindows() abort
  if &background ==# 'light'
    highlight NormalNC guifg=#444444 ctermfg=238 guibg=#eeeeee ctermbg=255
  else
    highlight NormalNC guifg=#bcbcbc ctermfg=250 guibg=#262626 ctermbg=235
  endif
endfunction

" Markdown punctuation (e.g., header and list markers, backticks, link
" brackets) and URLs use `Comment`, and code and link text use `Special`
function! auto#HighlightMarkdown() abort
  for l:group in ['markdownHeadingDelimiter', 'markdownListMarker',
        \ 'markdownCodeDelimiter', 'markdownLinkDelimiter',
        \ 'markdownLinkTextDelimiter', 'markdownUrlDelimiter',
        \ 'markdownUrlTitleDelimiter', 'markdownItalicDelimiter',
        \ 'markdownBoldDelimiter', 'markdownBoldItalicDelimiter',
        \ 'markdownStrikeDelimiter', 'markdownRule', 'markdownCheckbox',
        \ 'markdownUrl']
    execute 'highlight! link' l:group 'Comment'
  endfor
  for l:group in ['markdownCode', 'markdownCodeBlock', 'markdownLinkText',
        \ 'markdownUrlTitle', 'markdownId',
        \ 'markdownIdDeclaration']
    execute 'highlight! link' l:group 'Special'
  endfor
  if has('nvim')
    " The captures with `.markdown` and `.markdown_inline` suffixes are from
    " `queries/markdown/highlights.scm` and
    " `queries/markdown_inline/highlights.scm`
    for l:group in ['@markup.heading.marker.markdown', '@markup.list.markdown',
          \ '@markup.list.checked.markdown', '@markup.list.unchecked.markdown',
          \ '@punctuation.special.markdown', '@punctuation.delimiter.markdown',
          \ '@punctuation.delimiter.markdown_inline', '@markup.link.url.markdown',
          \ '@markup.link.url.markdown_inline']
      execute 'highlight! link' l:group 'Comment'
    endfor
    for l:group in ['@markup.raw.markdown_inline', '@markup.raw.block.markdown',
          \ '@markup.link.markdown_inline', '@markup.link.label.markdown',
          \ '@markup.link.label.markdown_inline']
      execute 'highlight! link' l:group 'Special'
    endfor
  endif
endfunction
