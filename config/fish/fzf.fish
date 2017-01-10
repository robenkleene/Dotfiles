# fzf
function ack_lines
  # ag
  # ag --nobreak --noheading $argv
  # rg
  rg --no-heading $argv
end
function ack_lines_color
  # ag
  # ack_lines --color $argv
  # rg
  ack_lines --color=always $argv
end
function ack_lines_no_color
  # ag
  # ack_lines --nocolor $argv
  # rg
  ack_lines --color=never $argv
end

# ag
# set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore ".git" -g ""'
# rg
set -x FZF_DEFAULT_COMMAND 'rg --files -g ""'

# Helper
function fzf-process-result
  if [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
    set -g FZFRESULT (cat $TMPDIR/fzf.result)
    and echo $FZFRESULT
    rm -f $TMPDIR/fzf.result
    return 0
  else
    set -e FZFRESULT
    rm -f $TMPDIR/fzf.result
    return 1
  end
end

# Store in Variable

# File
function fzf-file
  fzf > $TMPDIR/fzf.result
  fzf-process-result
end

# Directory
function fzf-directory
  find * -type d | fzf  > $TMPDIR/fzf.result
  fzf-process-result
end

# Use from variable
function fzf-result-vim
  test -n "$FZFRESULT"
  and vim-edit "$FZFRESULT"
end
function fzf-result-cd
  test -n "$FZFRESULT"
  and cd "$FZFRESULT"
end

# Directories

# cd
function fzf-directory-cd
  find * -type d | fzf  > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and cd "$result"
end

# cd
function fzf-history-cd
  fasd -l | fzf  > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and cd "$result"
end

# Files

# emacs
function fzf-file-emacs
  # Using `xargs` causes tmux `pane_current_path` to fail
  # fzf | tr '\n' '\0' | xargs -0 -o emacs
  fzf > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and emacs-edit "$result"
end

# vim
function fzf-file-vim
  # Using `xargs` causes tmux `pane_current_path` to fail
  # fzf | tr '\n' '\0' | xargs -0 -o vim
  fzf > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and vim-edit "$result"
end

# mate
function fzf-file-mate
  fzf | tr '\n' '\0' | xargs -0 mate
end

# bbedit
function fzf-file-bbedit
  fzf | tr '\n' '\0' | xargs -0 bbedit
end

# reveal
function fzf-file-reveal
  fzf | tr '\n' '\0' | xargs -0 open -R
end

# open
function fzf-file-open
  fzf | tr '\n' '\0' | xargs -0 open
end

# cd
function fzf-file-cd
  fzf > $TMPDIR/fzf.result
  set result (dirname (fzf-process-result))
  and cd "$result"
end

# path
function fzf-file-path
  fzf | tr -d '\n' | tee /dev/tty | pbcopy
end

# Lines

# vim
function fzf-line-vim
  ack_lines_no_color "[a-zA-Z0-9]+" . | fzf --ansi > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and echo $result | vim -c "GrepBuffer" - 
end

# Snippets

# Copy
function fzf-snippet
  fzf-snippet-copy
end

function fzf-snippet-copy
  cd ~/Development/Snippets/
  find * -type f | fzf | tr '\n' '\0' | xargs -0 cat | tee /dev/tty | pbcopy
  cd -
end

# Reveal
function fzf-snippet-reveal
  cd ~/Development/Snippets/
  find * -type f | fzf | tr '\n' '\0' | xargs -0 open -R
  cd -
end

# TextMate
function fzf-snippet-mate
  cd ~/Development/Snippets/
  find * -type f | fzf | tr '\n' '\0' | xargs -0 mate
  cd -
end

# vim
function fzf-snippet-vim
  cd ~/Development/Snippets/
  # Using `xargs` causes tmux `pane_current_path` to fail
  # find * -type f | fzf | tr '\n' '\0' | xargs -0 -o vim
  find * -type f | fzf > $TMPDIR/fzf.result
  cd -

  set result (fzf-process-result)
  and vim-edit "$HOME/Development/Snippets/$result"
end

# Project

# Xcode
function fzf-project-xcode
  find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | grep -vE "\/Carthage\/" | fzf  --select-1 | tr '\n' '\0' | xargs -0 open
end

function fzf-file-xcode
  # rg
  # `ag` version isn't written yet
  set ack_search_xcode $FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\"
  eval $ack_search_xcode | fzf  --select-1 | tr '\n' '\0' | xargs -0 open -a "Xcode"
end

# ack

function fzf-ack-vim
  echo $argv | tr -d '\n' | pbcopy -pboard find
  ack_lines_color $argv . | fzf --ansi > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and echo $result | vim-edit -c "GrepBuffer" -c "let @/='$argv[-1]' | let @0=@* | set hlsearch" -
end

function fzf-ack-bbedit
  echo $argv | tr -d '\n' | pbcopy -pboard find
  ack_lines_color $argv . | fzf --ansi > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and echo $result | awk -F  ":" '{ print "+"$2 " " $1 }' | tr '\n' '\0' | xargs -0 -I '{}' sh -c "bbedit {}"
end

function fzf-ack-mate
  echo $argv | tr -d '\n' | pbcopy -pboard find
  ack_lines_color $argv . | fzf --ansi > $TMPDIR/fzf.result
  set result (fzf-process-result)
  and echo $result | awk -F  ":" '{ print "--line="$2 " " $1 }' | tr '\n' '\0' | xargs -0 -I '{}' sh -c "mate {}"
end
