%

# `fish` Troubleshooting

To solve `TERMINFO` issues, e.g., ""could not set up terminal". run:

    env TERMINFO=/usr/share/terminfo fish

Then:

    brew reinstall ncurses

## Profiling

- `fish --profile-startup fish.profile -i -c exit`: Store startup profiling to `fish.profile`

First column `Time` is time of command itself, `Sum` is time of command plus function calls and process substitution
