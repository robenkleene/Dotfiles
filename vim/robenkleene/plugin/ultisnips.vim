" Check for snippets from only one location and always edit snippets with
" `UltiSnipsEdit` at that location
" Note that the documentation says that this should be a single value rather
" than an array, but it only works if it's an array.
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="context"
