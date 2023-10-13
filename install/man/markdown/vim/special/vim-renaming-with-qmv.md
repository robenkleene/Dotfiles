# `vim` Renaming With `qmv`

Renaming with `qmv` is usually straightforward, but if a find and replace needs to be performed it can be more complicated.

1. Use visual block mode to select the second, destination, column and delete it with `d`
2. Paste it to the bottom of the file
3. Use visual mode to do a find and replace on the selection
4. Select the text again with visual block mode
5. Go to the start of the column and paste it again

Note that the last step will fail if `set clipboard^=unnamed` is set.
