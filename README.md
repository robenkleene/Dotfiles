# Nothing to see here

## Install

### Shared

If it's *not a personal machine*, install a user-scoped Homebrew (the same for both Mac and Linux), and then install without the `-m` flag:

```
git clone --depth=1 https://github.com/Homebrew/brew ~/.brew
mkdir -p ~/Developer && cd ~/Developer && git clone https://github.com/robenkleene/Dotfiles.git && ./Dotfiles/install/install.sh
```

### Personal

If it's a personal machine for both Mac and Linux, make sure the machine has `ssh` access to GitHub and Bitbucket, then install Homebrew normally, and run install with the `-m` flag:

```
mkdir -p ~/Developer && cd ~/Developer && git clone git@github.com:robenkleene/Dotfiles.git && ./Dotfiles/install/install.sh -m
```
