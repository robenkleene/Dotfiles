- `<silent>` makes a mapping not echo to minibuffer, e.g. in `nnoremap <silent> <buffer> gd :OpenDiff<CR>`
- `map <return> ]q`: Example of quickly mapping return to the next quickfix match from Unimpaired

## Removing

- `:unmap <key>`: Remove a `:map` binding
- `:nunmap <key>`: Remove a `:nmap` binding
- `:iunmap <key>`: Remove a `:imap` binding
