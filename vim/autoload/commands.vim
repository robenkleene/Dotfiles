" Make the current buffer a grep buffer
function! commands#GrepBuffer() abort
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  " `cbuffer`: Convert to `quickfix`
  " `bprevious`: Go back to grep input
  " `bdelete`: Delete the grep buffer
  if line('$') == 1
    " Don't show the quickfix list if there's exactly one match
    execute "cbuffer | bprevious | bdelete"
  else
    execute "cbuffer | bprevious | bdelete | cw | wincmd k"
  endif
endfunction

" Disable backgrounding
function! commands#DisableBackgrounding() abort
  nnoremap <C-z> :echom "Backgrounding is disabled"<CR>
  vnoremap <C-z> :echom "Backgrounding is disabled"<CR>
endfunction

" Save & Restore Sessions
function! commands#QuitSaveSession() abort
  SessionSave
  qa
endfunction

" Go to `git` root
function! commands#Cdw(command) abort
  let l:working_directory = getcwd(-1)
  if v:shell_error == 0
    execute a:command.' '.fnameescape(l:working_directory)
    echo l:working_directory
  else
    echo "Error changing directory ".a.command .' '.fnameescape(l:working_directory)
  endif
endfunction

" Go to `git` root
function! commands#Cdg(command) abort
  let l:git_root = system('git rev-parse --show-toplevel | tr -d "\n"')
  if v:shell_error == 0
    execute a:command.' '.fnameescape(l:git_root)
    echo l:git_root
  else
    echo "Not in a git respository."
  endif
endfunction

" Inbox
function! commands#Inbox(...) abort
  let l:title = get(a:, 1, 0)
  if empty(l:title)
    if exists(':Dirvish')
      execute 'Dirvish ~/Documents/Text/Inbox/'
    else
      execute 'Explore ~/Documents/Text/Inbox/'
    endif
  else
    let l:filename = system('~/.bin/inbox_new '.shellescape(l:title))
    execute 'edit '.l:filename
  endif
endfunction

" Archive
function! commands#Archive() abort
  if &modified
    echoerr "Buffer is modified"
    return
  endif
  let message = system('~/.bin/backup_file '.fnameescape(expand('%:p')))
  echo message
  bdelete!
endfunction

" `rg`
function! commands#Rg(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
  " Without `silent`, the terminal output is seen and enter is required to go
  " to the first match
  execute "silent grep " . escape(a:terms, '%#')
  if !has('nvim')
    " The screen gets messed up in `vim` without this
    redraw!
  endif
  let &grepprg = l:original_grepprg
  if len(getqflist())
    copen
    " `copen` gives the quickfix focus, `wincmd p` switches back to the
    " previous window
    wincmd p
  endif
endfunction

" From `git` root
function! commands#Rgg(terms) abort
  call commands#Cdg('cd')
  execute "Rg " . a:terms
endfunction

" `rg` & `tmux`
function! commands#Atm(terms) abort
  let l:original_grepprg = &grepprg
  set grepprg=tmux-paths-rg
  execute "grep " . a:terms
  let &grepprg = l:original_grepprg
endfunction

" Splits
function! commands#NewFileType(type) abort
  " Note it seems like it's impossible to make a function take an optional
  " range, because at the `command`-level whether there is a visual selection
  " or not gets lost
  " A nice feature if that were possible would be to have the split start with
  " the visual selection, here's some code for that:
  " let s:selection = join(getline("'<", "'>"), "\n")
  let l:current_filetype = &filetype
  execute a:type
  let &filetype = l:current_filetype
  " let reg_save = @@
  " let @@ = s:selection
  " normal ""p
  " let @@ = reg_save
endfunction

function! commands#NewScratch(bang, type) abort
  let l:scratch_path = "~/Development/Scratch/Document/" 
  if (a:bang == 1)
    if exists(':Dirvish')
      execute 'Dirvish' l:scratch_path
    else
      execute 'Explore' l:scratch_path
    endif
    return
  endif
  let l:extension = expand('%:e')
  if !strlen(l:extension)
    let l:extension = '*'
  end
  let l:current_filetype = &filetype
  let l:path = l:scratch_path . l:current_filetype . "." . l:extension
  execute a:type l:path
endfunction

function! s:valid_register(register) abort
  if a:register=~'\v^(\a|\d|"|\*|\.|:|\%|#|\\|\=)$'
    return 1
  end
  return 0
endfunction
function! commands#NewRegister(register, type) abort
  if !s:valid_register(a:register)
    echom a:register." is not a valid register."
    return
  end
  execute a:type
  " Don't prompt when closing this buffer
  set buftype=nofile
  execute "normal \"".a:register."p"
endfunction

function! commands#WriteRegister(register) abort
  if !s:valid_register(a:register)
    echom a:register." is not a valid register."
    return
  end
  execute "normal ggvGg_\"".a:register."d"
  bd
endfunction

" Lint
function! commands#Lint() abort
  if !exists('b:LintMakePrg')
    echo "No b:LintMakePrg defined"
    return
  endif
  let l:original_makeprg = &makeprg
  let l:original_errorformat = &errorformat
  let &makeprg = b:LintMakePrg
  let &errorformat = b:LintErrorFormat
  make
  let &makeprg = l:original_makeprg
  let &errorformat = l:original_errorformat
endfunction

function! commands#DeleteEOFWhitespace() abort
  let l:cursor_pos = getpos(".")
  execute '0;/^\%(\_s*\S\)\@!/,$d'
  call cursor(l:cursor_pos[1], l:cursor_pos[2])
endfunction

" Format
function! commands#Format() abort
  if !exists('b:FormatPrg')
    echo "No b:FormatPrg defined"
    return
  endif
  let l:cursor_pos = getpos(".")
  execute "%!" . b:FormatPrg
  call cursor(l:cursor_pos[1], l:cursor_pos[2])
endfunction

" Execute
function! commands#Execute() abort
  if !exists('b:ExecutePrg')
    echo "No b:ExecutePrg defined"
    return
  endif
  execute "%w !" . b:ExecutePrg
endfunction

function! commands#ExecuteVisual() abort
  if !exists('b:ExecutePrg')
    echo "No b:ExecutePrg defined"
    return
  endif
  execute "'<,'>w !" . b:ExecutePrg
endfunction

" Run
function! commands#Run() abort
  if !exists('b:RunMakePrg')
    echo "No b:RunMakePrg defined"
    return
  endif
  let l:original_makeprg = &makeprg
  let l:original_errorformat = &errorformat
  let &makeprg = b:RunMakePrg
  if exists('b:RunErrorFormat')
    let &errorformat = b:RunErrorFormat
  endif
  make
  let &makeprg = l:original_makeprg
  let &errorformat = l:original_errorformat
endfunction

function commands#SlugProject(name) abort
  let l:filename = system('~/.bin/slug_project '. a:name)
  execute 'edit '.l:filename
endfunction

" Tags
function! commands#Tags() abort
  silent execute "!~/.bin/generate_tags -e"
  redraw!
endfunction

" Profile
function! commands#ProfileStart() abort
  profile start profile.log
  profile func *
  profile file *
endfunction

function! commands#ProfileEnd() abort
  profile pause
  noautocmd qall!
endfunction

" Markdown
function! commands#RenameFileFromTitle() abort
  if &filetype !=# 'markdown'
    echom "This command only works with Markdown files"
    return
  endif
  let l:filename = system('~/.bin/markdown_rename -s -p '.fnameescape(expand('%:p')))
  if v:shell_error != 0
      echom "Failed to rename file"
      return
  endif
  execute 'edit '.l:filename
endfunction

" Blog
function! commands#BlogNewPost(title, flags) abort
  let l:filename = system('~/.bin/jekyll_new_draft ' . a:flags . ' -t '. a:title)
  execute 'edit '.l:filename
endfunction

function! commands#BlogNewPostWithFile(flags) abort
  let l:filename = system('~/.bin/jekyll_new_draft ' . a:flags . ' -f '.fnameescape(expand('%:p')))
  execute 'edit '.l:filename
endfunction

" Journal
function! commands#JournalNew() abort
  let l:filename = system('~/.bin/journal_new_make_default')
  execute 'edit '.l:filename
endfunction

" Open Source Control
function! commands#SourceControlWeb() abort
  echo system('~/.bin/source_control_open_site')
endfunction

function! commands#QuitIfNoBuffers() abort
  if (tabpagenr('$') == 1 && winnr() == 1 && len(expand('%'))==0)
    q!
  endif
endfunction
