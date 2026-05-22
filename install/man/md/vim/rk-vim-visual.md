- `⌃v`: Visual Block Mode
- `gv`: Reselect last visual block

## Blocks

- `vip`: Select paragraph
- `va{V`: Select current function
- `V$%`: More reliable way to select current function

## Notes

Text cut with `^v` or `v` is `blockwise`, if you then paste it, the text will interleave with any lines it overlaps with. To get around this behavior, just use the `:put` command, which pastes the text as if it were yanked `linewise`.

## Visual Block Mode

Easy to edit before and after the selection:

1. `C-v`: Start the selection
2. `hjkl`: Select the relevant text

# Inserting Text Before / After Selection

Use `I` or `A` to insert text at the beginning or end of the selection

# Examples

## Deleting

- Delete text from the beginning of the line by starting a block selection (`C-v`) then selecting the text, then hitting `x`
- Delete text from the end of the line from a specific column by starting a block selection (`C-v`) from where to delete from, then going to the last line to perform the delete on, then `$` to go to the end of the line, then `x` to delete

## Pasting

- Paste a column of text after another column of text by performing a delete (`x`) or yank (`y`) after a block selection (`C-v`) (in order to assure the yanked text is a `blockwise` itself [otherwise it will all be inserted into a single line]) on the text to paste, then performing another block selection on the lines to paste too, then going to the end of the line (`$`), then pasting (`p`)
- It's impossible to insert a `blockwise` selection to the ends of lines that aren't the same length (as an alternative use the shell command `col` then work with tab-delimited columns)
