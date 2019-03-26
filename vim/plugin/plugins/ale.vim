let g:ale_linters_explicit = 1
let g:ale_linters = {
  \   'css': ['stylelint'],
  \   'scss': ['stylelint'],
  \   'html': ['stylelint', 'tidy'],
  \   'ruby': ['rubocop', 'ruby'],
  \   'javascript': ['eslint'],
  \   'objc': ['clang'],
  \   'swift': ['swiftlint'],
  \   'xml': ['xmllint'],
  \   'sh': ['shell', 'shellcheck'],
  \   'zsh': ['shell', 'shellcheck'],
  \}
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
