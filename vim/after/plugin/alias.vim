if !exists(':Alias')
  finish
endif

Alias G Git
Alias A Rg
Alias Af Rg\ -F

" Compilers
Alias CXC compiler\ xcodebuild

" Plugins

" LineDiff
Alias -range Ld Linediff
Alias Ldr LinediffReset

" UltiSnips
Alias Se UltiSnipsEdit
Alias Gw silent\ !git_web_open
" Using the silent version of this causes Vim's UI to disappear for some
" reason
" Alias Slpr silent\ !slug_project
Alias Slpr SlugProject
