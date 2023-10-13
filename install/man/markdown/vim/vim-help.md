# `vim` Help

See `:help help-summary`.

## General

- `:h :command`: Used for `cmdline` commands (e.g., `:help :help`)
- `:h 'option'`: Options (e.g., `:help 'incsearch'`)
- `:h function()`: Functions (e.g., `bufnr()`)
- `K`: Help for keyword under the cursor

### Prefixes

- `c_`: prefix for command line (e.g., `:help c_%`)
- `i_`: prefix for insert mode (e.g., `:help i_CTRL-[` or `:help i_^[`)
- `v_`: prefix for visual mode (e.g., `:help v_CTRL-]` or `:help v_^]`)
- No prefix for normal mode commands (e.g., `:help CTRL-]` or `:help ^]`).

### Less Used

- `>`: Prefix for commands for debugging (`:help >cont`)
- `/`: Prefix for regular expression items (`:help /\+`)
- `quote`: Prefix for registers (`:help quote:`)

## Tag Match List

After executing `help {subject}` command, the matches for the `{subject}` are stored on the `tag-matchlist`. Navigating to help tags adds those tags to the `tagstack`. 

[`vim` tags documentations](vim-tags.md)

## Tips

* `/|` or `f|`: Jump to the next tag in the document or line

## Help Example

			       *'ballooneval'* *'beval'* *'noballooneval'* *'nobeval'*
	'ballooneval' 'beval'	boolean	(default off)
				global
				{not in Vi}
				{only available when compiled with the |+balloon_eval|
				feature}
		Switch on the |balloon-eval| functionality.

- `*'ballooneval'*`: Tags for this help entry
- `'ballooneval' 'beval'`: Long and short form of the option name
- `{}`: Nothing special about these notes
- `|balloon-eval|`: Tags that you can jump to (with `<C-]>`)
