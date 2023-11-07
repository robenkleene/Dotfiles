# Nothing to see here

## Install

If it's not a personal machine, install Homebrew locally, then run install without the `-m` flag:

    git clone --depth=1 https://github.com/Homebrew/brew ~/.brew
    mkdir -p ~/Developer && cd ~/Developer && git clone https://github.com/robenkleene/Dotfiles.git && ./Dotfiles/install/install.sh

If it's a personal machine, make sure the machine has `ssh` access to GitHub and Bitbucket, then install Homebrew normally, and run install with the `-m` flag:

    mkdir -p ~/Developer && cd ~/Developer && git clone git@github.com:robenkleene/Dotfiles.git && ./Dotfiles/install/install.sh -m
