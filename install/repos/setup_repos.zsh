#!/usr/bin/env zsh

dry_run=true
use_https=false
include_private=true
while getopts ":fpHh" option
  do case "$option" in
    f)
      dry_run=false
      ;;
    H)
      use_https=true
      ;;
    p)
      include_private=false
      ;;
    h)
      echo "Usage: ./setup-repos.zsh [-hHr]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if $dry_run; then
  echo "Dry Run\n"
fi

if $use_https; then
  github_prefix='https://github.com/'
  bitbucket_prefix='https://bitbucket.org/'
  bitbucket_postfix='/'
else
  github_prefix='git@github.com:'
  bitbucket_prefix='git@bitbucket.org:'
  bitbucket_postfix=''
fi

typeset -A repos
repos=(
~"/Developer/Dotfiles/" "${github_prefix}robenkleene/Dotfiles.git"
~"/Developer/Snippets/" "${github_prefix}robenkleene/Snippets.git"
~"/Developer/AppleScripts/" "${github_prefix}robenkleene/AppleScripts.git"
)

if [[ "$include_private" == "true" ]]; then
  repos+=(
~"/Developer/Scratch/" "${bitbucket_prefix}robenkleene/scratch.git$bitbucket_postfix"
~"/Developer/Settings/" "${bitbucket_prefix}robenkleene/settings.git$bitbucket_postfix"
~"/Developer/Archive/" "${bitbucket_prefix}robenkleene/archive.git$bitbucket_postfix"
~"/Developer/Backup/" "${bitbucket_prefix}robenkleene/backup.git$bitbucket_postfix"
)
fi

if [[ "$(uname)" = "Darwin" ]]; then
  repos+=(
~"/Library/Application Support/BBEdit/" "${github_prefix}robenkleene/BBEdit.git"
~"/Library/Developer/Xcode/UserData/" "${github_prefix}robenkleene/Xcode-UserData.git"
)
  # if [[ "$include_private" == "true" ]]; then
  #   repos+=(
# ~"/Music/Audio Music Apps/" "${bitbucket_prefix}robenkleene/audio-music-apps.git$bitbucket_postfix"
  #   )
  # fi
fi

# Overwrite with a simple set for non-personal machines
if [[ ! -f "$HOME/.personal" ]]; then
  repos=(
~"/Developer/Snippets/" "${github_prefix}robenkleene/Snippets.git"
)
fi

for directory in "${(@k)repos}"; do
  remote="$repos[$directory]"
  # Test it's a directory
  if [[ -d "$directory" ]]; then
    current=$(cd "$directory"; git ls-remote --get-url 2> /dev/null | tr -d '\n')
    # Test that it can get the remote
    if (($? > 0)); then
      echo "ERROR: Failed to get the git remote URL at $directory"
    else
      # Test that the remote is accurate
      if [[ "$current" != "$remote" ]]; then
        echo
        echo "ERROR: The remote does not match $remote in $directory did you mean to use the '-H' option to use 'https'?"
        echo "current = $current"
        echo "remote = $remote"
        echo
      else
        echo "The remote is correct for $directory"
      fi
    fi
  else
    echo "Cloning $remote into $directory"
    exitstatus=0
    if ! $dry_run; then
      git clone $remote "$directory"
      exitstatus=$?
    fi
    if (($exitstatus > 0)); then
      echo "ERROR: Failed cloning $remote into $directory"
    fi
  fi
done
