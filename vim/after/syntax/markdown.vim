syn region markdownCodeBlock start="    \|\t" end="$" contained contains=@NoSpell

" Disable spell checking in links because too many copy and pasted links have
" spelling errors
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" keepend nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart,@NoSpell

" Hack to add only level of nested list support
syn match markdownListMarker "\%(\t\| \+\)[-*+]\%(\s\+\S\)\@=" contained
syn match markdownOrderedListMarker "\%(\t\| \+\)\<\d\+\.\%(\s\+\S\)\@=" contained
