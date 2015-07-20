" Load guard
if ( exists('g:loaded_ctrlp_directory_bookmarks') && g:loaded_ctrlp_directory_bookmarks )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_directory_bookmarks = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp_directory_bookmarks#init()',
	\ 'accept': 'ctrlp_directory_bookmarks#accept',
	\ 'lname': 'directory bookmarks',
	\ 'sname': 'directories',
	\ 'type': 'line',
	\ })


" Provide a list of strings to search in
"
" Return: a Vim's List
"
if !exists('g:loaded_ctrlp_directory_bookmarks')
  let g:ctrlp_directory_bookmarks_list = [] 
endif

function! ctrlp_directory_bookmarks#init()
  return g:ctrlp_directory_bookmarks_list
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp_directory_bookmarks#accept(mode, str)
	" For this example, just exit ctrlp and run help
	call ctrlp#exit()
  execute 'edit' a:str
endfunction



" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp_directory_bookmarks#id()
	return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/sample.vim
command! CtrlPDirectoryBookmarks call ctrlp#init(ctrlp_directory_bookmarks#id())


" vim:nofen:fdl=0:ts=2:sw=2:sts=2
