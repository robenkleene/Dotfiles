iabbrev :btab: ⇤
iabbrev :cmd: ⌘
iabbrev :ctrl: ⌃
iabbrev :darr: ↓
iabbrev :del: ⌫
iabbrev :esc: ⎋
iabbrev :fdel: ⌦
iabbrev :kso: ⌤↓↑←→⎋⌦⌫↩⇥⇤␣
iabbrev :kss: ⇧⌃⌥⌘
iabbrev :larr: ←
iabbrev :opt: ⌥
iabbrev :rarr: →
iabbrev :ret: ↩
iabbrev :ent: ⌤
iabbrev :sft: ⇧
iabbrev :spc: ␣
iabbrev :tab: ⇥
iabbrev :uarr: ↑

function! s:InsertTitle()
    let l:filename = expand('%:p')
    let l:title = system('~/.bin/md_title ' . shellescape(l:filename) . ' | grep .')
    return l:title
endfunction
iabbrev :title: <C-R>=<SID>InsertTitle()<CR>
