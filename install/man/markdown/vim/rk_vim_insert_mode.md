There's no `C-b` / `C-e` to go to the beginning and end of line, like on the command line. The best alternative is `C-o ^` / `C-o $` (`C-o` performs one normal mode command).

- `⇧←` / `⇧→`, `⌥←` / `⌥→`: Move left / right by word
- `C-a`: Insert last inserted text
- `C-e`: Insert character below the cursor (more useful than it sounds, e.g., can be used to quickly insert Markdown checkbox list items on a new line)
- `C-@`: Insert last inserted text and leave insert mode
- `C-d` / `C-t`: indent / outdent line
- `C-g u`: Split undo
- `C-g j` / `C-g k`: Start a new line from same column insert was started at
- `C-p` / `C-n`: Insert word from earlier / later in buffer
- `C-o`: Do single normal command from insert mode
- `C-r <register>`: Paste from register
- `C-r C-p <register>`: Paste from register without indenting
- `C-u`: Delete to beginning of line
- `C-w`: Delete previous word
- `C-v`: Insert literal character (like `<tab>` when tab inserts spaces)
- `C-x`: Completion prefix
- `C-j`: Insert new line
- `C-k`: Insert digraph
- `<C-\><C-O>`: Perform normal command but don't shift cursor at end of line
- `<C-]>`: Trigger abbreviation
- There's no delete forward word, instead use `⇧→ C-w`
