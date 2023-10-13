%

# `git-clone`

## Shallow

`git clone` without history:

	git clone --depth 1 https://github.com/qmk/qmk_firmware.git

To update:

    git fetch --depth 1
    git reset --hard origin/master
    git clean -dfx
