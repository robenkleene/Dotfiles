- `<silent>` makes a mapping not echo to minibuffer, e.g. in `nnoremap <silent> <buffer> gd :OpenDiff<CR>`
- `map <return> ]q` / `map <bs> [q`: Example of quickly mapping return / backspace to the next / previous `quickfix` match using the Unimpaired bindings

## Removing

- `:unmap <key>`: Remove a `:map` binding
- `:nunmap <key>`: Remove a `:nmap` binding
- `:iunmap <key>`: Remove a `:imap` binding
