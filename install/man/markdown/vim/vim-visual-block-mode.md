# Vim Visual Block Mode

Easy to edit before and after the selection:

1. `C-v`: Start the selection
2. `hjkl`: Select the relevant text

## Inserting Text Before / After Selection

Use `I` or `A` to insert text at the beginning or end of the selection

## Deleting Text From the Start of the Line

Just make selection and hit `x`

## Deleting Text to the End of the Line

Difficult with visual block mode, but `<range>norm!` (the `!` ignores mappings) can be used in a pinch, e.g., `%norm! ED` to delete everything after the first big word on each line in the file.
