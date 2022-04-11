" This doesn't work for some reason
" highlight link QuickFixSignsDiffAdd DiffAdded
" highlight link QuickFixSignsDiffDelete DiffRemoved
" highlight link QuickFixSignsDiffChange DiffChange
highlight QuickFixSignsDiffAdd guifg=green guibg=NONE gui=bold cterm=bold
highlight QuickFixSignsDiffDelete guifg=red guibg=NONE gui=bold cterm=bold
highlight QuickFixSignsDiffChange guifg=darkcyan guibg=NONE gui=bold cterm=bold

sign define QFS_QFL text=> texthl=DiffText

let g:quickfixsigns#vcsdiff#highlight = {'DEL': 'DiffDelete', 'ADD': 'DiffAdd', 'CHANGE': 'DiffChange'}
