if test "$TERM" = 'xterm-ghostty' || "$TERM_PROGRAM" = 'vscode'
  if ! functions -q rg
    # `--with-filename` when searching a single file, e.g., `rg <term> <file>`,
    # the filename is omitted which means hyperlinks don't work. Forcing the
    # filename makes hyperlinks work.
    # alias rg="`which rg` --with-filename --hyperlink-format vscode://file/{path}:{line}:{column}"
    alias rg=rg_delta
  end
  if ! functions -q hg
    alias hg="`which hg` --config pager.pager='delta --hyperlinks --hyperlinks-file-link-format vscode://file/{path}:{line}'"
  end
  set -x GIT_PAGER 'delta --relative-paths --hyperlinks --hyperlinks-file-link-format vscode://file/{path}:{line}'
  if ! functions -q delta
    alias delta="`which delta` --relative-paths --hyperlinks --hyperlinks-file-link-format vscode://file/{path}:{line}"
  end
  alias fd="`which fd` --hyperlink"
else
  if ! functions -q rg
    alias rg="`which rg` --no-heading --with-filename --line-number --column"
  end
end
