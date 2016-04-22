# fzf
set -x FZF_DEFAULT_COMMAND 'ag -g ""'

# Directories

# cd
function fzf-directory-cd
  find * -type d | fzf  > $TMPDIR/fzf.result
  [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
  and cd (cat $TMPDIR/fzf.result)
  commandline -f repaint
  rm -f $TMPDIR/fzf.result
end

# Files

# emacs
function fzf-file-emacs
  sh -c "emacs \"\$(/usr/local/bin/fzf)\""
end

# vim
function fzf-file-vim
  sh -c "vim \"\$(/usr/local/bin/fzf)\""
end

# mate
function fzf-file-mate
  sh -c "mate \"\$(/usr/local/bin/fzf)\""
end

# reveal
function fzf-file-reveal
  sh -c "open -R \"\$(/usr/local/bin/fzf)\""
end

# open
function fzf-file-open
  sh -c "open \"\$(/usr/local/bin/fzf)\""
end

# Lines

# vim
function fzf-line-vim
  ag --nocolor --nobreak --noheading "[a-zA-Z0-9]+" . | fzf > $TMPDIR/fzf.result
  if [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
    cat $TMPDIR/fzf.result | vim -c "GrepBuffer" -
  end
  rm -f $TMPDIR/fzf.result
end

# Bookmarks

# cd to bookmark
# Basic
set -x RKBOOKMARKS ~/Dotfiles/ ~/Development/ ~/Development/Scratch/ ~/Development/Projects/ ~/Dropbox/Text/
# Vim
set -x RKBOOKMARKS $RKBOOKMARKS ~/Dotfiles/vim/plugged/ ~/Dotfiles/vim/robenkleene/ ~/Dotfiles/vim/after/
# Fish
set -x RKBOOKMARKS $RKBOOKMARKS ~/Dotfiles/config/fish/
# Copy with a `:` separator for more portability for other shells
set -x ROBENKLEENE_BOOKMARKS (echo -s :$RKBOOKMARKS | cut -b 2-)
function fzf-bookmark-cd
  printf '%s\n' $RKBOOKMARKS | fzf  > $TMPDIR/fzf.result
  [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
  and cd (cat $TMPDIR/fzf.result)
  commandline -f repaint
  rm -f $TMPDIR/fzf.result
end

# Snippets

# Copy
function fzf-snippet-copy
  sh -c "cat ~/Development/Snippets/\$(cd ~/Development/Snippets/; find * -type f | /usr/local/bin/fzf) | tee /dev/tty | pbcopy"
end

# Reveal
function fzf-snippet-reveal
  sh -c "open -R ~/Development/Snippets/\$(cd ~/Development/Snippets/; find * -type f | /usr/local/bin/fzf)"
end

# TextMate
function fzf-snippet-mate
  sh -c "mate ~/Development/Snippets/\$(cd ~/Development/Snippets/; find * -type f | /usr/local/bin/fzf)"
end

# vim
function fzf-snippet-vim
  sh -c "vim ~/Development/Snippets/\$(cd ~/Development/Snippets/; find * -type f | /usr/local/bin/fzf)"
end

# Project

# fzf Xcode

function fzf-project-xcode
  find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | fzf | tr '\n' '\0' | xargs -0 open
end
