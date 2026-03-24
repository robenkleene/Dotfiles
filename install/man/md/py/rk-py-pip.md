Always install Python dependencies with the user flag: `pip install --usr`.

# List Package Install Locations

    pip3 list -v

# `bin`

To list the path for `--user` installed dependencies:

    python3 -m site --user-base

To add the `bin` to your path, take that directory, just take that path an append `bin`.

# Delete All Packages

	pip3 freeze > dump.txt

Then:

	cat dump.txt | xargs pip3 uninstall -y
