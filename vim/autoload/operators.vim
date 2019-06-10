function! operators#WebSearch(type, ...) abort
  " `@@` is an alias for `@"`, the unnamed register
  let sel_save = &selection
  " From `h :map-operator`: The 'selection' option is temporarily set to
  " "inclusive" to be able to yank exactly the right text by using Visual mode
  " from the '[ to the '] mark.
  let &selection = "inclusive"
  let reg_save = @@
  let reg_save2 = @*

  if a:0 " Invoked from Visual mode, use `gv` command.
    " Visual
    silent exe "normal! gvy"
  elseif a:type == 'line'
    " Line
    silent exe "normal! '[V']y"
  else
    " Character
    silent exe "normal! `[v`]y"
  endif

  silent exe system("~/.bin/web_search ".shellescape(@@))
  let &selection = sel_save
  let @@ = reg_save
  let @* = reg_save2
endfunction

function! operators#TitleCase(type, ...) abort
  " `@@` is an alias for `@"`, the unnamed register
  let reg_save = @@
  let reg_save2 = @*

  if a:0
    " Visual
    silent exe "normal! gvc\<C-r>=system('~/.bin/title_case',@\")\<CR>\<ESC>"
  elseif a:type == 'line' " Line
    " Line
    silent exe "normal! '[V']c\<C-r>=system('~/.bin/title_case',@\")\<CR>\<ESC>"
  else
    " Character
    silent exe "normal! `[v`]c\<C-r>=system('~/.bin/title_case',@\")\<CR>\<ESC>"
  endif

  let @@ = reg_save
  let @* = reg_save2
  redraw
  echom "Title case"
endfunction

function! operators#MarkdownWikiLink(type, ...) abort
  " `@@` is an alias for `@"`, the unnamed register
  let reg_save = @@
  let reg_save2 = @*

  if a:0
    " Visual
    silent exe "normal! gvc\<C-r>=system('~/.bin/markdown_wiki_link '.fnameescape(expand(expand('%:h'))),@@.\"\\n\")\<CR>\<ESC>"
  elseif a:type == 'line' " Line
    " Line
    silent exe "normal! '[V']c\<C-r>=system('~/.bin/markdown_wiki_link '.fnameescape(expand(expand('%:h'))),@@.\"\\n\")\<CR>\<ESC>"
  else
    " Character
    silent exe "normal! `[v`]c\<C-r>=system('~/.bin/markdown_wiki_link '.fnameescape(expand(expand('%:h'))),@@.\"\\n\")\<CR>\<ESC>"
  endif

  let @@ = reg_save
  let @* = reg_save2
endfunction

function! operators#OpenURLs(type, ...) abort
  " `@@` is an alias for `@"`, the unnamed register
  let sel_save = &selection
  " From `h :map-operator`: The 'selection' option is temporarily set to
  " "inclusive" to be able to yank exactly the right text by using Visual mode
  " from the '[ to the '] mark.
  let &selection = "inclusive"
  let reg_save = @@
  let reg_save2 = @*

  if a:0 " Invoked from Visual mode, use `gv` command.
    " Visual
    silent exe "normal! gvy"
  elseif a:type == 'line'
    " Line
    silent exe "normal! '[V']y"
  else
    " Character
    silent exe "normal! `[v`]y"
  endif

  call system('~/.bin/urls_open', @@)

  let &selection = sel_save
  let @@ = reg_save
  let @* = reg_save2
endfunction

function! operators#LinkReplace(type, ...) abort
  " `@@` is an alias for `@"`, the unnamed register
  let reg_save = @@
  let reg_save2 = @*

  echom "Replacing phrases with links"

  if a:0
    " Visual
    silent exe "normal! gvc\<C-r>=system('~/.bin/link_phrase',@\")\<CR>\<ESC>"
  elseif a:type == 'line' " Line
    " Line
    silent exe "normal! '[V']c\<C-r>=system('~/.bin/link_phrase',@\")\<CR>\<ESC>"
  else
    " Character
    silent exe "normal! `[v`]c\<C-r>=system('~/.bin/link_phrase',@\")\<CR>\<ESC>"
  endif

  let @@ = reg_save
  let @* = reg_save2
endfunction

function! operators#Archive(type, ...) abort
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  let reg_save2 = @*

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

  let message = system('~/.bin/backup_text -m', @@)
  let &selection = sel_save
  let @@ = reg_save
  let @* = reg_save2
  " Force a redraw so the `echom` doesn't disappear
  redraw
  echom message
endfunction

function! operators#ArchiveAndDelete(type, ...) abort
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  let reg_save2 = @*

  if a:0
    " Visual
    silent exe "normal! gvd"
  elseif a:type == 'line'
    " Line
    silent exe "normal! '[V']d"
  else
    " Character
    silent exe "normal! `[v`]d"
  endif

  let message = system('~/.bin/backup_text -m', @@)
  let &selection = sel_save
  let @@ = reg_save
  let @* = reg_save2
  " Force a redraw so the `echom` doesn't disappear
  redraw
  echom message
endfunction

" " Backup Text
" function! bindings#ArchiveLines(bang) range abort
"   let file_path = system('echo '.shellescape(join(getline(a:firstline, a:lastline), '\n')).' | '.'~/.bin/backup_text')
"   if (a:bang == 1)
"     let temp = @s
"     silent normal! gv"sd
"     let @s = temp
"   endif
"   let lineCount = system('wc -l < '.fnameescape(file_path).' | tr -d " " | tr -d "\n"')
"   echom "Backed up ".lineCount." lines"
" endfunction

