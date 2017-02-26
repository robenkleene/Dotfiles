# `resolvedir` is an array whose first item is either `$TMPDIR` or `/tmp` if
# that's nil
set resolvedir $TMPDIR /tmp
set tmpdir $resolvedir[1]

function ack-lines
  # ag
  # ag --nobreak --noheading $argv
  # rg
  rg --no-heading $argv
end
function ack-lines-color
  # ag
  # ack-lines --color $argv
  # rg
  ack-lines --color=always $argv
end
function ack-lines-no-color
  # ag
  # ack-lines --nocolor $argv
  # rg
  ack-lines --color=never $argv
end

# ag
# set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore ".git" -g ""'
# rg
set -x FZF_DEFAULT_COMMAND 'rg --files -g ""'

# Helper
function fzf-process-result
  if [ (cat $tmpdir/fzf.result | wc -l) -gt 0 ]
    set -g FZFRESULT (cat $tmpdir/fzf.result)
    and echo $FZFRESULT
    rm -f $tmpdir/fzf.result
    return 0
  else
    set -e FZFRESULT
    rm -f $tmpdir/fzf.result
    return 1
  end
end

# Directories

# history
function fzf-recent-cd
  fasd -l | fzf  > $tmpdir/fzf.result
  set result (fzf-process-result)
  and cd "$result"
end

function fzf-bookmark-cd
  # Bookmarks
  set RKBOOKMARKS ~/Dotfiles/ 
  # Documentation
  set RKBOOKMARKS $RKBOOKMARKS ~/Documentation/ ~/Documentation/development-references/
  # Development
  set RKBOOKMARKS $RKBOOKMARKS ~/Development/ ~/Development/Scratch/ ~/Development/Projects/ ~/Development/Scripts/ ~/Development/Snippets/

  printf '%s\n' $RKBOOKMARKS | fzf > $tmpdir/fzf.result
  set result (fzf-process-result)
  and cd "$result"
end

# Files

# emacs
function fzf-file-emacs
  # Using `xargs` causes tmux `pane_current_path` to fail
  # fzf | tr '\n' '\0' | xargs -0 -o emacs
  fzf > $tmpdir/fzf.result
  set result (fzf-process-result)
  and emacs-edit "$result"
end

# vim
function fzf-file-vim
  # Using `xargs` causes tmux `pane_current_path` to fail
  # fzf | tr '\n' '\0' | xargs -0 -o vim
  fzf > $tmpdir/fzf.result
  set result (fzf-process-result)
  and vim-edit "$result"
end

# tig
function fzf-file-tig
  fzf > $tmpdir/fzf.result
  set result (fzf-process-result)
  and tig "$result"
end

# tmux
function fzf-tmux-window
  if test -z "$TMUX"
    return
  end
   tmux list-windows | awk 'BEGIN{FS=" "} {print $1 $2}' | fzf | awk 'BEGIN{FS=":"} {print $1}' > $tmpdir/fzf.result
  set result (fzf-process-result)
  and tmux select-window -t ":$result"
end

# mate
if test (uname) = Darwin
  function fzf-file-mate
    fzf | tr '\n' '\0' | xargs -0 mate
  end
end

# bbedit
if test (uname) = Darwin
  function fzf-file-bbedit
    fzf | tr '\n' '\0' | xargs -0 bbedit
  end
end

# reveal
if test (uname) = Darwin
  function fzf-file-reveal
    fzf | tr '\n' '\0' | xargs -0 open -R
  end
end

# open
if test (uname) = Darwin
  function fzf-file-open
    fzf | tr '\n' '\0' | xargs -0 open
  end
end

# cd
function fzf-file-cd
  fzf > $tmpdir/fzf.result
  set result (dirname (fzf-process-result))
  and cd "$result"
end

# path
function fzf-file-path
  fzf | tr -d '\n' | tee /dev/tty | safecopy
end

# Documentation
function fzf-documentation-vim
  cd ~/Documentation/
  # Using `xargs` causes tmux `pane_current_path` to fail
  # find * -type f | fzf | tr '\n' '\0' | xargs -0 -o vim
  find * -type f -not -path '*/\.*' | fzf > $tmpdir/fzf.result
  cd -
  set result (fzf-process-result)
  and vim-edit "$HOME/Documentation/$result"
end

# Lines

# vim
function fzf-line-vim
  ack-lines-no-color "[a-zA-Z0-9]+" . | fzf --ansi > $tmpdir/fzf.result
  set result (fzf-process-result)
  and echo $result | vim -c "GrepBuffer" - 
end

# Snippets

# Copy
function fzf-snippet-copy
  cd ~/Development/Snippets/
  find * -type f | fzf | tr '\n' '\0' | xargs -0 cat | tee /dev/tty | safecopy
  cd -
end

# vim
function fzf-snippet-vim
  cd ~/Development/Snippets/
  # Using `xargs` causes tmux `pane_current_path` to fail
  # find * -type f | fzf | tr '\n' '\0' | xargs -0 -o vim
  find * -type f | fzf > $tmpdir/fzf.result
  cd -

  set result (fzf-process-result)
  and vim-edit "$HOME/Development/Snippets/$result"
end

# Project

# Xcode
if test (uname) = Darwin
  function fzf-project-xcode
    find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | grep -vE "\/Carthage\/" | fzf  --select-1 | tr '\n' '\0' | xargs -0 open
  end
end

if test (uname) = Darwin
  function fzf-file-xcode
    # rg
    # `ag` version isn't written yet
    set ack_search_xcode $FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\"
    eval $ack_search_xcode | fzf  --select-1 | tr '\n' '\0' | xargs -0 open -a "Xcode"
  end
end

# ack

function fzf-ack-vim
  echo $argv | tr -d '\n' | safecopy -pboard find
  ack-lines-color $argv . | fzf --ansi > $tmpdir/fzf.result
  set result (fzf-process-result)
  if test (uname) = Darwin
    set setup_system_clipboard "| let @0=@*"
  end
  and echo $result | vim-edit -c "GrepBuffer" -c "let @/='$argv[-1]' $setup_system_clipboard | set hlsearch" -
end


if test (uname) = Darwin
  function fzf-ack-bbedit
    echo $argv | tr -d '\n' | safecopy -pboard find
    ack-lines-color $argv . | fzf --ansi > $tmpdir/fzf.result
    set result (fzf-process-result)
    and echo $result | awk -F  ":" '{ print "+"$2 " " $1 }' | tr '\n' '\0' | xargs -0 -I '{}' sh -c "bbedit {}"
  end
end

if test (uname) = Darwin
  function fzf-ack-mate
    echo $argv | tr -d '\n' | safecopy -pboard find
    ack-lines-color $argv . | fzf --ansi > $tmpdir/fzf.result
    set result (fzf-process-result)
    and echo $result | awk -F  ":" '{ print "--line="$2 " " $1 }' | tr '\n' '\0' | xargs -0 -I '{}' sh -c "mate {}"
  end
end
