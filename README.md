# Nothing to see here

## Install

Install homebrew locally:

    git clone --depth=1 https://github.com/Homebrew/brew ~/.brew

Then:

    sudo rmdir ~/Library/Services/
    mkdir -p ~/Development && cd ~/Development && git clone https://github.com/robenkleene/Dotfiles.git && ./Dotfiles/install.sh

Or, if you're me, install homebrew normally, then:

    sudo rmdir ~/Library/Services/
    mkdir -p ~/Development && cd ~/Development && git clone git@github.com:robenkleene/Dotfiles.git && ./Dotfiles/install.sh -m
