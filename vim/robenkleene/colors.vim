" Colors {{{1

" Notes for working with colors:
" `XtermColorTable` displays the hex colors a terminal equivalents
" `:so $VIMRUNTIME/syntax/colortest.vim` displays the named colors
" Or use my command `:RunColorTest`
" Colorscheme
set background=dark
colorscheme tir_black

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

" Highlight {{{2
let s:highlightbgcolor = '237'
let s:highlightfgcolor = 'NONE'

let s:highlightgroups = ['CursorLine', 'CursorLineNr', 'Wildmenu']
for group in s:highlightgroups
  exe 'highlight ' . group . ' ctermbg=' . s:highlightbgcolor  . ' ctermfg=' .  
        \ s:highlightfgcolor
endfor

" Selection {{{2
" BG: #b2b2b2 FG: #585858
let s:selectionbgcolor = '240'
let s:selectionfgcolor = '249'
let s:selectiongroups = ['Visual', 'MatchParen']
for group in s:selectiongroups
  exe 'highlight ' . group . ' ctermbg=' . s:selectionbgcolor  . ' ctermfg=' .  
        \ s:selectionfgcolor
endfor
" Search {{{3
highlight IncSearch cterm=underline ctermbg=NONE ctermfg=white
highlight Search cterm=underline ctermfg=white ctermbg=NONE

" StatusLine {{{2
highlight StatusLine ctermbg=white ctermfg=242
highlight StatusLineNC ctermfg=237 ctermbg=249
highlight TabLine cterm=NONE ctermbg=237 ctermfg=249
highlight TabLineFill cterm=NONE ctermbg=237 ctermfg=249

" ColorColumn {{{2
highlight ColorColumn ctermbg=237
" Tildes
highlight NonText ctermfg=darkgray

" Vimdiff Colors {{{2
highlight DiffAdd ctermfg=green ctermbg=darkgreen
highlight DiffDelete ctermfg=red ctermbg=darkred
highlight DiffChange ctermfg=NONE ctermbg=NONE
highlight DiffText ctermfg=lightblue ctermbg=darkblue

" Git Gutter Colors {{{2
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=lightblue
highlight GitGutterDelete ctermfg=red
highlight GitGutterAddDefault ctermbg=NONE ctermfg=green
highlight GitGutterChangeDefault ctermbg=NONE ctermfg=lightblue
highlight GitGutterDeleteDefault ctermbg=NONE ctermfg=red
highlight GitGutterAddInvisible ctermbg=NONE ctermfg=green
highlight GitGutterChangeInvisible ctermbg=NONE ctermfg=lightblue
highlight GitGutterDeleteInvisible ctermbg=NONE ctermfg=red

" Syntastic Colors {{{2
highlight SyntasticErrorSign ctermfg=red
highlight SyntasticWarningSign ctermfg=yellow
highlight SyntasticStyleWarningSign ctermfg=yellow
" highlight SyntasticErrorLine ctermbg=red

" Warning Message {{{2
highlight WarningMsg ctermfg=white ctermbg=red cterm=bold
