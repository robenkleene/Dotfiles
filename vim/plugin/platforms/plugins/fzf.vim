if has('gui_running')
  " Use `ctrlp` instead
  finish
endif

" Make a separate command so that `:Tags` can be used to generate tags
" command! -bang -nargs=* FZFTags call fzf#vim#tags(<q-args>, <bang>0)

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :BLines<CR>
" nnoremap <leader>f :Files<CR>
nnoremap <M-e> :CheckHomeSubdirectory<CR>:Files<CR>
" Fix `<C-@>` `<C-Space>` in `vim`
" nnoremap <C-@> :Commands<CR>
" vnoremap <C-@> :Commands<CR>
" nnoremap <C-Space> :Commands<CR>
" vnoremap <C-Space> :Commands<CR>
nnoremap <M-x> :Commands<CR>
vnoremap <M-x> :VisualCommands<CR>
nnoremap <M-c> :CheckHomeSubdirectory<CR>:Cd<CR>
nnoremap <M-z> :Z<CR>
nnoremap <M-o> :Quick<CR>
nnoremap <M-O> :QuickFiles<CR>
" For some reason the above binding doesn't work, but the below one does
" This can't be used because Vim can't distinguish between `<M-O>` and the
" arrow keys
" nnoremap O :QuickFiles<CR>
nnoremap <M-g> :Developer<CR>
" nnoremap <M-r> :Zvim<CR>
nnoremap <leader>r :History<CR>
nnoremap <localleader>i :BTags<CR>
nnoremap <leader>i :FZFTags<CR>
nnoremap <M-i> :FZFTags<CR>
if has('nvim')
  " inoremap <M-c> <C-\><C-o>:lcd %:p:h<CR><C-\><C-o>:Cdinsert<CR>
  " inoremap <M-e> <C-\><C-o>:lcd %:p:h<CR><C-\><C-o>:Filesinsert<CR>
  inoremap <M-c> <C-\><C-o>:CheckHomeSubdirectory<CR><C-\><C-o>:RelativeCdinsert<CR>
  inoremap <M-e> <C-\><C-o>:CheckHomeSubdirectory<CR><C-\><C-o>:RelativeFilesinsert<CR>
  inoremap <M-z> <C-\><C-o>:CheckHomeSubdirectory<CR><C-\><C-o>:RelativeZinsert<CR>
  " inoremap <M-i><M-c> <C-\><C-o>:RelativeCdinsert<CR>
  " inoremap <M-i><M-e> <C-\><C-o>:RelativeFilesinsert<CR>
  " inoremap <M-i>c <C-\><C-o>:RelativeCdinsert<CR>
  " inoremap <M-i>e <C-\><C-o>:RelativeFilesinsert<CR>
else
  " inoremap <M-c> <C-\><C-o>:lcd %:p:h<CR><C-\><C-o>:Cdinsert<CR><right>
  " inoremap <M-e> <C-\><C-o>:lcd %:p:h<CR><C-\><C-o>:Filesinsert<CR><right>
  inoremap <M-c> <C-\><C-o>:CheckHomeSubdirectory<CR><C-\><C-o>:RelativeCdinsert<CR><right>
  inoremap <M-e> <C-\><C-o>:CheckHomeSubdirectory<CR><C-\><C-o>:RelativeFilesinsert<CR><right>
  inoremap <M-z> <C-\><C-o>:CheckHomeSubdirectory<CR><C-\><C-o>:RelativeZinsert<CR><right>
  " inoremap <M-i><M-c> <C-\><C-o>:RelativeCdinsert<CR>
  " inoremap <M-i><M-e> <C-\><C-o>:RelativeFilesinsert<CR>
  " inoremap <M-i>c <C-\><C-o>:RelativeCdinsert<CR>
  " inoremap <M-i>e <C-\><C-o>:RelativeFilesinsert<CR>
endif

command! -range CheckHomeSubdirectory call <SID>CheckHomeSubdirectory()
function! s:CheckHomeSubdirectory() abort
  if getcwd()."/" !~ glob2regpat($HOME.'/*/*')
    echoerr "Only use in a subdirectory of home"
    return 1
  endif
  return 0
endfunction

" A version of `:Commands` that can take a range
command! -range VisualCommands call <SID>VisualCommands()
function! s:VisualCommands() abort
  call fzf#vim#commands()
  norm gv
endfunction

" Documentation
" command! Doc call fzf#run(fzf#wrap({
"       \   'source': $FZF_DEFAULT_COMMAND,
"       \   'sink': function('<SID>sview_lcd_sink'),
"       \   'dir': '~/Documentation/'
"       \ }))
" command! Doce call fzf#run(fzf#wrap({
"       \   'source': $FZF_DEFAULT_COMMAND,
"       \   'sink': function('<SID>split_lcd_sink'),
"       \   'dir': '~/Documentation/'
"       \ }))
" Combined `Doc` and `Doce` into one command because otherwise if you open
" file with `Doc` and then try to edit it with `Doce`, editting still won't be
" enabled because the buffer was already opened as view only.
command! Doc call fzf#run(fzf#wrap({
      \   'source': $FZF_DEFAULT_COMMAND,
      \   'sink': function('<SID>split_lcd_sink'),
      \   'dir': '~/Documentation/'
      \ }))
command! Doce call fzf#run(fzf#wrap({
      \   'source': $FZF_DEFAULT_COMMAND,
      \   'sink': function('<SID>split_lcd_sink'),
      \   'dir': '~/Documentation/'
      \ }))

function! s:split_lcd_sink(e) abort
  execute 'split ' a:e

  " This doesn't work
  let l:path = expand('%:p:h')
  if !empty(l:path)
    lcd %:p:h
  endif
endfunction

function! s:sview_lcd_sink(e) abort
  execute 'sview' a:e

  " This doesn't work
  let l:path = expand('%:p:h')
  if !empty(l:path)
    lcd %:p:h
  endif
endfunction

" Note from the `tmux-paths` script: "The front program can change the `pwd`,
" which might result in paths appearing to be missing."
command! TmuxPaths :call fzf#run(fzf#wrap({
      \   'source':  "tmux-paths",
      \   'sink': function('<SID>cd_sink')
      \ }))

function! s:cd_sink(e) abort
  call s:file_manager(a:e)
  " execute 'Explore' a:e
  let l:path = expand('%')
  if !empty(l:path)
    " This should be an `lcd` but that doesn't work reliably
    " cd %
    lcd %
  endif
endfunction

function! s:file_manager(directory) abort
  if exists(':Dirvish')
    execute 'Dirvish' a:directory
  else
    execute 'Explore' a:directory
  endif
endfunction

" Modified Files
command! Modified :call fzf#run(fzf#wrap({
      \   'source': "git ls-files -m | uniq",
      \   'sink': 'e'
      \ }))

command! Cd :call fzf#run(fzf#wrap({
      \   'source': "cmd=\"${FZF_ALT_C_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type d -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
      \   'sink':   function('<SID>file_manager')
      \ }))

command! Z :call fzf#run(fzf#wrap({
      \   'source': "fasd -Rdl",
      \   'sink': function('<SID>cd_sink')
      \ }))

command! Zvim :call fzf#run(fzf#wrap({
      \   'source': "fasd -Rfl",
      \   'sink': 'e'
      \ }))

command! FZFTags :call fzf#run(fzf#wrap({
      \   'source': "~/.bin/dump_tags",
      \   'sink': 'tag'
      \ }))

command! Quick :call fzf#run(fzf#wrap({
      \   'source': "fd --type d . ~/Text ~/Documentation",
      \   'sink': function('<SID>cd_sink')
      \ }))
command! QuickFiles :call fzf#run(fzf#wrap({
      \   'source': "fd --type f . ~/Text ~/Documentation",
      \   'sink': function('<SID>cd_sink')
      \ }))
command! Developer :call fzf#run(fzf#wrap({
      \   'source': "fd --type d . ~/Developer",
      \   'sink': function('<SID>cd_sink')
      \ }))

" Insert
function! s:insert(string) abort
  let temp = @s
  let @s = a:string
  " Need to use a different paste depending if the cursor is at the end of the
  " line
  " if col('.') == col('$') - 1
  if col('.') == col('$') && col('.') != 1
    normal "sp
  else
    normal "sP
  end
  let @s = temp
  " `nvim` leaves insert mode when performing one of the insert mappings, this
  " should re-enter insert mode, but it's not working either.
  if has('nvim')
    startinsert
  endif
endfunction

function! s:relative_file_insert(path) abort
  let origin_file = expand('%')
  let destination = a:path
  let workingdir = getcwd()
  let shell_edit = 0
  if origin_file =~ "^/private/tmp/" && workingdir !~ "^/private/tmp/"
    " If the current file is a temp directory, but the working directory is
    " not a temp directory, that's strong indication we're editing a shell
    " command (e.g., with `<C-x><C-e>`, in which case we want to use the
    " working directory as a origin_file so we can complete file paths when editing
    " shell commands (i.e., the temp file for the command is irrelevant in
    " this case).
    let origin_file = workingdir
    let shell_edit = 1
  end
  let result = system('~/.bin/relative_path '.shellescape(origin_file).' '.shellescape(destination).' | tr -d "\n"')
  let temp = @s
  if shell_edit
    " Use shell escaping if editing a shell command
    let @s = shellescape(result)
  else
    let @s = result
  end
  " Need to use a different paste depending if the cursor is at the end of the
  " line
  if col('.') == col('$') && col('.') != 1
    normal "sp
  else
    normal "sP
  end
  " let @s = temp
  " `nvim` leaves insert mode when performing one of the insert mappings, this
  " should re-enter insert mode, but it's not working either.
  if has('nvim')
    startinsert
  endif
endfunction

command! Cdinsert :call fzf#run(fzf#wrap({
      \   'source': "cmd=\"${FZF_ALT_C_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type d -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
      \   'sink':   function('<SID>insert')
      \ }))
command! Filesinsert :call fzf#run(fzf#wrap({
      \   'source': "cmd=\"${FZF_CTRL_T_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type f -print -o -type d -print -o -type l -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
      \   'sink':   function('<SID>insert')
      \ }))
command! RelativeCdinsert :call fzf#run(fzf#wrap({
      \   'source': "cmd=\"${FZF_ALT_C_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type d -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
      \   'sink':   function('<SID>relative_file_insert')
      \ }))
command! RelativeFilesinsert :call fzf#run(fzf#wrap({
      \   'source': "cmd=\"${FZF_CTRL_T_COMMAND:-\"command find -L . -mindepth 1 \\\\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\\\) -prune -o -type f -print -o -type d -print -o -type l -print 2> /dev/null | cut -b3-\"}\" && eval \"$cmd\"",
      \   'sink':   function('<SID>relative_file_insert')
      \ }))
command! RelativeZinsert :call fzf#run(fzf#wrap({
      \   'source': "fasd -Rdl",
      \   'sink':   function('<SID>relative_file_insert')
      \ }))

" Support a `TagBuffer` function that opens the current file contents as a
" tag.
command! TagBuffer :call <SID>TagBuffer()
function! s:TagBuffer() abort
  execute "setlocal buftype=nofile bufhidden=hide noswapfile"
  let lines = getline(1,'$')
  bdelete
  return s:open_tags(lines)
endfunction
function! s:open_tags(lines)
  execute "tag ".a:lines[0]
endfunction
function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction
