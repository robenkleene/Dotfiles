# ag
# set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore ".git" -g ""'
# rg
set -x FZF_DEFAULT_COMMAND 'rg --files -g ""'

# Private

function _robenkleene_ack_lines
  # ag
  # ag --nobreak --noheading $argv
  # rg
  rg --no-heading $argv
end
function _robenkleene_ack_lines_color
  # ag
  # _robenkleene_ack_lines --color $argv
  # rg
  _robenkleene_ack_lines --color=always $argv
end
function _robenkleene_ack_lines_no_color
  # ag
  # _robenkleene_ack_lines --nocolor $argv
  # rg
  _robenkleene_ack_lines --color=never $argv
end

function _robenkleene_fzf_inline
  set result_cmd $argv[1]
  if test (count $argv) -gt 1
    set list_cmd $argv[2]
  else
    set list_cmd $FZF_DEFAULT_COMMAND
  end
  set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS"
    eval "$list_cmd | "(__fzfcmd)" +m" | read -l result
    if [ "$result" ]
      set final_cmd $result_cmd $result
      eval $final_cmd
    end
  end
end

function _robenkleene_fzf_inline_result
  if test (count $argv) -gt 0
    set list_cmd $argv[1]
  else
    set list_cmd $FZF_DEFAULT_COMMAND
  end
  set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS"
    eval "$list_cmd | "(__fzfcmd)" +m" | read -l result
    echo $result
  end
end


# Directories

# History
function fzf-recent-cd
  _robenkleene_fzf_inline cd "fasd -ld"
end

function fzf-bookmark-cd
  # Bookmarks
  set -l bookmarks ~/Development/Dotfiles/ 
  # Documentation
  set bookmarks $bookmarks ~/Documentation/ ~/Documentation/development-references/
  # Development
  set bookmarks $bookmarks ~/Development/ ~/Development/Scratch/ ~/Development/Projects/ ~/Development/Scripts/ ~/Development/Snippets/

  _robenkleene_fzf_inline cd "printf '%s\n' $bookmarks"
end

# Files

# Vim
function fzf-file-vim
  _robenkleene_fzf_inline vim-edit
end

# Reveal
if test (uname) = Darwin
  function fzf-file-reveal
    _robenkleene_fzf_inline "open -R"
  end
end

# Open
if test (uname) = Darwin
  function fzf-file-open
    _robenkleene_fzf_inline open
  end
end

# Path
function fzf-file-cd
  _robenkleene_fzf_inline_result | read -l result
  if [ $result ]
    cd (dirname $result)
  end
end
function fzf-file-path
  _robenkleene_fzf_inline_result | read -l result
  if [ $result ]
    and echo $result | tr -d '\n' | tee /dev/tty | safecopy
  end
end


# Documentation
function fzf-documentation-less
  cd ~/Documentation/
  _robenkleene_fzf_inline_result | read -l result
  if [ $result ]
    cat "$result" | less
  end
  cd -
end
function fzf-documentation-vim
  cd ~/Documentation/
  _robenkleene_fzf_inline_result | read -l result
  if [ $result ]
    vim-edit "$result"
  else
    cd -
  end
end

# Lines

# vim
function fzf-line-vim
  set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --ansi --reverse $FZF_DEFAULT_OPTS"
    eval "_robenkleene_ack_lines_no_color \"[a-zA-Z0-9]+\" . | "(__fzfcmd)" +m" | read -l result
    if [ "$result" ]
      echo $result | vim -c "GrepBuffer" -   
    end
  end
end

# Snippets
function fzf-snippet-copy
  cd ~/Development/Snippets/
  _robenkleene_fzf_inline_result | read -l result
  if [ $result ]
    cat "$result" | less
  end
  cd -
end
function fzf-snippet-vim
  cd ~/Development/Snippets/
  _robenkleene_fzf_inline_result | read -l result
  if [ $result ]
    vim-edit "$result"
  else
    cd -
  end
end

# Xcode
if test (uname) = Darwin
  function fzf-project-xcode
    set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
    begin
      set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --select-1 --reverse $FZF_DEFAULT_OPTS"
      eval "find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | grep -vE \"\/Carthage\/\" | "(__fzfcmd)" +m" | read -l result
      if [ "$result" ]
        echo $result | tr '\n' '\0' | xargs -0 open
      end
    end
  end
end
if test (uname) = Darwin
  function fzf-file-xcode
    set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
    begin
      set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --select-1 --reverse $FZF_DEFAULT_OPTS"
      eval "$FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\" | "(__fzfcmd)" +m" | read -l result
      if [ "$result" ]
        echo $result | tr '\n' '\0' | xargs -0 open -a "Xcode"
      end
    end
  end
end

# ack
function fzf-ack-vim
  echo $argv | tr -d '\n' | safecopy -pboard find
  if test (uname) = Darwin
    set setup_system_clipboard "| let @0=@*"
  end
  set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --ansi --reverse $FZF_DEFAULT_OPTS"
    eval "_robenkleene_ack_lines_color $argv . | "(__fzfcmd)" +m" | read -l result
    if [ "$result" ]
      echo $result | vim-edit -c "GrepBuffer" -c "let @/='$argv[-1]' $setup_system_clipboard | set hlsearch" -
    end
  end
end
