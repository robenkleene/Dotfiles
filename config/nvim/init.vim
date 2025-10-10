set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
set notermguicolors
" Using a clipboard provider allows transparent clipboard support through
" local and remote development (i.e., when `ssh` into a system, copying to the
" system clipboard via `"*y`, will even work over `ssh` via OSC52 terminal
" clipboard support)
" The problem with this approach is that there's one case that behaves
" strangely: Pasting from the system clipboard when over `ssh`, this is
" because the local version of `safecopy` isn't aware of the update to the
" system clipboard)
" For this reason, as a general rule:
" - `"*` followed by a yank, should copy to the system and `tmux` clipboard
" - `"*` followed by a paste, should paste only from the `tmux` clipboard
" This way, only the operations that always work both locally and remotely are
" supported in both cases.
" Note that the above means the native clipboard shortcut (e.g., command-v on
" macOS should always be used to paste into Vim)

" Try commenting out the paste, this makes Vim more consistent with what's
" supported by Emacs and the shell, this is because the OSC52 protocol only
" supports copy, not paste.

" Using Vim instead
" The problem with using Vim is that Vim doesn't support `"*` on Linux

" Support remote clipboard, note that only copy is supported remotely, e.g.,
" `"*p` to paste from the remote clipboard will fail.
" Note: This currently isn't working, fails with an error running
" `_safecopy.sh`
let g:clipboard = {
      \ 'name': 'safe',
      \ 'copy': {
      \    '+': expand('~/.bin/nobin/_safecopy.sh'),
      \    '*': expand('~/.bin/nobin/_safecopy.sh'),
      \ },
      \ 'paste': {
      \    '+': expand('~/.bin/nobin/_safepaste.sh'),
      \    '*': expand('~/.bin/nobin/_safepaste.sh'),
      \  },
      \ 'cache_enabled': 1,
      \ }

" Don't load the default `:Man` command, use the `vim-man` plugin instead
" because it supports `<tab>` complection with `MANPATH`
let g:loaded_man = 1
