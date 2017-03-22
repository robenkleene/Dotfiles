" Check for snippets from only one location and always edit snippets with
" `UltiSnipsEdit` at that location
" Note that the documentation says that this should be a single value rather
" than an array, but it only works if it's an array.
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
" Note that this only works for tab stops before the last `$0` tab stop this
" is because UltiSnips exits after reaching the last tab stop.
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="context"
