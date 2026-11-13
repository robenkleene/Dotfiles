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
  elseif has('gui_running')
    " Lighter than the Xcode Black `Normal` background in `gvimrc` (`#292A30`)
    highlight NormalNC guifg=#bcbcbc guibg=#34353B
  else
    highlight NormalNC guifg=#bcbcbc ctermfg=250 guibg=#262626 ctermbg=235
  endif
endfunction

" - `Comment`: Secondary text, light grey on a dark background and dark grey on
"   a light background
" - `Delimiter`: Punctuation, a middle grey
" - `Special`: The blue from the Ghostty theme (`palette = 4=#5FAFFF`),
"   `ctermfg=4` uses palette 4 directly
function! auto#HighlightText() abort
  if &background ==# 'light'
    highlight Comment guifg=#585858 ctermfg=240 guibg=NONE ctermbg=NONE
  else
    highlight Comment guifg=#B2B2B2 ctermfg=249 guibg=NONE ctermbg=NONE
  endif
  highlight Delimiter guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
  highlight Special guifg=#5FAFFF ctermfg=4 guibg=NONE ctermbg=NONE
  if has('nvim')
    " `@punctuation.special` otherwise falls back to `Special`
    for l:group in ['@punctuation.delimiter', '@punctuation.bracket',
          \ '@punctuation.special']
      execute 'highlight! link' l:group 'Delimiter'
    endfor
  endif
  call auto#HighlightMarkdown()
endfunction

" Markdown punctuation (e.g., header and list markers, backticks, link
" brackets) and URLs use `Delimiter`, code uses `Comment`, and link text uses
" `Special`
function! auto#HighlightMarkdown() abort
  for l:group in ['markdownHeadingDelimiter', 'markdownListMarker',
        \ 'markdownCodeDelimiter', 'markdownLinkDelimiter',
        \ 'markdownLinkTextDelimiter', 'markdownUrlDelimiter',
        \ 'markdownUrlTitleDelimiter', 'markdownItalicDelimiter',
        \ 'markdownBoldDelimiter', 'markdownBoldItalicDelimiter',
        \ 'markdownStrikeDelimiter', 'markdownRule', 'markdownBlockquote',
        \ 'markdownCheckbox', 'markdownUrl']
    execute 'highlight! link' l:group 'Delimiter'
  endfor
  for l:group in ['markdownCode', 'markdownCodeBlock']
    execute 'highlight! link' l:group 'Comment'
  endfor
  for l:group in ['markdownLinkText', 'markdownUrlTitle', 'markdownId',
        \ 'markdownIdDeclaration']
    execute 'highlight! link' l:group 'Special'
  endfor
  if has('nvim')
    " `@punctuation` captures (e.g., from `queries/markdown/highlights.scm` and
    " `queries/markdown_inline/highlights.scm`) already use `Delimiter` from
    " `auto#HighlightText()`, these are the punctuation captures with other
    " names
    for l:group in ['@markup.heading.marker.markdown', '@markup.list.markdown',
          \ '@markup.list.checked.markdown', '@markup.list.unchecked.markdown',
          \ '@markup.link.url.markdown', '@markup.link.url.markdown_inline']
      execute 'highlight! link' l:group 'Delimiter'
    endfor
    for l:group in ['@markup.raw.markdown_inline', '@markup.raw.block.markdown']
      execute 'highlight! link' l:group 'Comment'
    endfor
    for l:group in ['@markup.link.markdown_inline', '@markup.link.label.markdown',
          \ '@markup.link.label.markdown_inline']
      execute 'highlight! link' l:group 'Special'
    endfor
  endif
endfunction
