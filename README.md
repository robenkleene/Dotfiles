# Nothing to see here

## Install

Install homebrew and nvm locally:

    git clone --depth=1 https://github.com/Homebrew/brew ~/.brew
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

Then:

    sudo rmdir ~/Library/Services/
    mkdir -p ~/Developer && cd ~/Developer && git clone https://github.com/robenkleene/Dotfiles.git && ./Dotfiles/install.sh

Or, if you're me, install homebrew (and nvm) normally, then:

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    sudo rmdir ~/Library/Services/
    mkdir -p ~/Developer && cd ~/Developer && git clone git@github.com:robenkleene/Dotfiles.git && ./Dotfiles/install.sh -m
