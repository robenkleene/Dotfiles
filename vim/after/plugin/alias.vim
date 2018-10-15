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
Alias Slpr silent\ !slug_project
