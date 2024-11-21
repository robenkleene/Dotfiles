The format used by Visual Studio Code and other editors.

`$0` designates the last placeholder, by default this is the end of the snippets. This means snippets that are meant to be used recursively should look like `[[ ${0:true} ]]` in order to not have to tab again at the end of the snippet and instead got to the next placeholder in a recursive snippet, while snippets that are a full statement themselves should typically use `$1` (without `$0`) so the last tab brings the cursor to the end of the snippet.

## Creating

The easiest way to create a complex snippet, with multiple lines and escaped characters, is to leverage multiple cursors.

1. Select the multi-line snippet
2. Enter multiple cursors (`⇧⌘I`).
3. Go to the beginning of each line (`⌃A`)
4. Hit delete, and then entire `\n`.
5. Select a character that needs escaping and do a find for it with `⌘E`. Select the entire line, make sure `Find in selection` is on (`⇧⌘L`). Hit `⌥↩` to create a cursor for each selection match, and escape the character. Repeat for each other character that needs escaping.

Typically `"` needs to be escaped, and `$` needs to be double escaped to prevent using it as tab-replacement.
