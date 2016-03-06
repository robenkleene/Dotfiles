" Colors {{{1

" Color Scheme {{{2

" Notes for working with colors:
" `XtermColorTable` displays the hex colors a terminal equivalents
" `:so $VIMRUNTIME/syntax/colortest.vim` displays the named colors
" Or use my command `:RunColorTest`
" Colorscheme
set background=dark
colorscheme tir_black
" tir_black bug fixes
" For some reason "blue" display weird in console vim when it overlaps with the
" highlighted cursorline (test this by running `RunColorTest` and then going
" to the `blue` or `darkblue` lines. Changes these colors to another fixes
" this)
hi rubyControl ctermfg=lightblue
hi rubyInterpolationDelimiter ctermfg=lightblue

" Background {{{2
let s:bgcolor = 'NONE'
let s:backgroundgroups = ['CursorColumn', 
      \ 'NonText', 'SpecialKey', 'VertSplit',
      \ 'Normal', 'SignColumn', 'FoldColumn']
" Set Background Colors
for group in s:backgroundgroups
  exe 'highlight ' . group . ' ctermbg=' . s:bgcolor
endfor

" Line Numbers {{{2
let s:guttercolor = 'NONE'
let s:guttergroups = ['LineNr']
for group in s:guttergroups
  exe 'highlight ' . group . ' ctermbg=' . s:guttercolor
endfor
highlight LineNr ctermfg=238

" Cursor Line & Wild Menu {{{2
let s:highlightbgcolor = '237'
let s:highlightfgcolor = 'NONE'

let s:highlightgroups = ['CursorLine', 'CursorLineNr', 'Wildmenu']
for group in s:highlightgroups
  exe 'highlight ' . group . ' ctermbg=' . s:highlightbgcolor  . ' ctermfg=' .  
        \ s:highlightfgcolor
endfor

" Visual Selection {{{2
" BG: #b2b2b2 FG: #585858
let s:selectionbgcolor = '240'
let s:selectionfgcolor = '249'
let s:selectiongroups = ['Visual', 'MatchParen']
for group in s:selectiongroups
  exe 'highlight ' . group . ' ctermbg=' . s:selectionbgcolor  . ' ctermfg=' .  
        \ s:selectionfgcolor
endfor

" Search {{{2
highlight IncSearch cterm=underline ctermbg=NONE ctermfg=white
highlight Search cterm=underline ctermfg=white ctermbg=NONE

" Status Line {{{2
highlight StatusLine ctermbg=white ctermfg=242
highlight StatusLineNC ctermfg=237 ctermbg=249

" Tabs {{{2
highlight TabLine cterm=NONE ctermbg=237 ctermfg=249
highlight TabLineFill cterm=NONE ctermbg=237 ctermfg=249

" Column Guide {{{2
highlight ColorColumn ctermbg=237

" Tildes {{{2
highlight NonText ctermfg=darkgray

" Warnings {{{2
highlight WarningMsg ctermfg=white ctermbg=red cterm=bold

" Diff {{{2
highlight DiffAdd ctermfg=green ctermbg=darkgreen
highlight DiffDelete ctermfg=red ctermbg=darkred
highlight DiffChange ctermfg=NONE ctermbg=NONE
highlight DiffText ctermfg=lightblue ctermbg=darkblue

" Folding {{{2
highlight Folded ctermfg=249 ctermbg=237

" Plugins {{{2

" Git Gutter {{{3
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=lightblue
highlight GitGutterDelete ctermfg=red
highlight GitGutterAddDefault ctermbg=NONE ctermfg=green
highlight GitGutterChangeDefault ctermbg=NONE ctermfg=lightblue
highlight GitGutterDeleteDefault ctermbg=NONE ctermfg=red
highlight GitGutterAddInvisible ctermbg=NONE ctermfg=green
highlight GitGutterChangeInvisible ctermbg=NONE ctermfg=lightblue
highlight GitGutterDeleteInvisible ctermbg=NONE ctermfg=red

" Syntastic {{{3
highlight SyntasticErrorSign ctermfg=red
highlight SyntasticWarningSign ctermfg=yellow
highlight SyntasticStyleWarningSign ctermfg=yellow
" highlight SyntasticErrorLine ctermbg=red
