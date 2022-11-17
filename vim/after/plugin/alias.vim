if !exists(':Alias')
  finish
endif

Alias G Git
" Alias A Rg
Alias Rgf Rg\ -F

Alias P :!safepaste
Alias Pq GrepBufferFromClipboard
Alias Gb GrepBuffer

Alias Eclip NewBufferWithClipboard
Alias Clip :new<CR>:NewBufferWithClipboard<CR>
Alias Vclip :vnew<CR>:NewBufferWithClipboard<CR>

" Compilers
Alias CXC compiler\ xcodebuild

" Clear quickfix
Alias Qc :cexpr\ []<CR>:cw<CR>
Alias Ac argdelete\ *
Alias C :cexpr\ []<CR>:cw<CR>:silent!\ argdelete\ *<CR><CR>:echo\ "Cleared"<CR>

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

" Languages
Alias Sh set\ filetype=sh
Alias Md set\ filetype=markdown
Alias Js set\ filetype=javascript
