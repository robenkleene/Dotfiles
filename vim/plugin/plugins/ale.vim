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
  \}
