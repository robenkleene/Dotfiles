if !exists(':Alias')
  finish
endif

Alias G Git
" Alias A Rg
Alias Rgf Rg\ -F

Alias Q GrepBufferFromClipboard

Alias Clip NewBufferWithClipboard

" Compilers
Alias CXC compiler\ xcodebuild

" Plugins

" LineDiff
Alias -range Ld Linediff
Alias Ldr LinediffReset

Alias Gw silent\ !git_web_open
" Using the silent version of this causes Vim's UI to disappear for some
" reason
" Alias Slpr silent\ !slug_project
Alias Slpr SlugProject

Alias Scw SourceControlWeb

Alias -range Snew NewScratch
Alias -range Svnew VnewScratch
Alias -range Vsnew VnewScratch
Alias Gcu !git_commit_update

" Languages
Alias Sh set\ filetype=sh
Alias Md set\ filetype=markdown
Alias Js set\ filetype=javascript
