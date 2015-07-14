" vim:foldmethod=marker

" UI {{{1

" Show 80 character bar
set colorcolumn=80 

" Highlight cursor line
set cursorline 
" Disable Cursor Line in Insert Mode
augroup disablecursorline
    autocmd!
    autocmd InsertEnter * set cursorline!
    autocmd InsertLeave * set cursorline
augroup END

" Fix quickfix colors
augroup quickfixcolors
    autocmd!
    " These interfere with quickfix highlighting
    autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal nocursorline | endif
    autocmd BufWinEnter * if &buftype == 'quickfix' | setlocal colorcolumn="" | endif
augroup END

" Show line numbers
set number 

" Highlight search results
set hlsearch 

" Don't display search highlight on startup
nohlsearch


" Colors {{{1

" Notes for working with colors:
" `XtermColorTable` displays the hex colors a terminal equivalents
" `:so $VIMRUNTIME/syntax/colortest.vim` displays the named colors
if !has('gui_running')
    " Colorscheme
    set background=dark
    colorscheme jellybeans

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
    " FG: #444444
    highlight LineNr ctermfg=238
    
    " Highlight {{{2
    " BG: #005f87 
    let s:highlightbgcolor = '24'
    let s:highlightfgcolor = 'white'
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
    highlight IncSearch ctermfg=240 ctermbg=white
    highlight Search cterm=NONE ctermfg=white ctermbg=240
    
    " StatusLine {{{2
    " BG: #afdfff
    highlight StatusLine ctermbg=153 ctermfg=black
    " NC StatusLine bg is gutter color
    highlight StatusLineNC ctermfg=lightgray ctermbg=238


    " ColorColumn {{{2
    highlight ColorColumn ctermbg=238
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
endif

 
" Status Line {{{1

set laststatus=2
" Space Buffer
set statusline=\ 
" Working Directory
set statusline+=%{fnamemodify(getcwd(),':t')}\ 
" Truncate Marker
set statusline+=%<
" Filename
set statusline+=%-.30f
" Modified
set statusline+=%m 
" Filetype
set statusline+=\ %y
" Syntastic
if exists(':SyntasticStatuslineFlag')
  set statusline+=\ 
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  set statusline+=\ 
endif

" Switch to right
set statusline+=%=
" Line
set statusline+=L%l
" Column
set statusline+=\ C%c
" Location
set statusline+=\ %P
" Git status
if exists(':fugitive')
  set statusline+=\ %{fugitive#statusline()}
endif
" Space Buffer
set statusline+=\ 
