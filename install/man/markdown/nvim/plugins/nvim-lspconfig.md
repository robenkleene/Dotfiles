# `nvim` `lspconfig`

- To apply formatting to all buffers in the `arglist` just use `:argodo norm <format-binding>`
- Telescope has a `require('telescope.builtin').diagnostics` that shows all diagnostics for a project
- `q`: Dismiss floating overlay

## Bindings

There's no way to scroll the pop-up window, instead you have to focus it, and then navigate within it.

## Troubleshooting

For `other clients that match the filetype`:

- Try `LspStart`
- Try running the LSP command directly, e.g., `rust-analyzer` was failing with `error: 'rust-analyzer' is not installed for the toolchain 'stable-x86_64-unknown-linux-gnu'`
