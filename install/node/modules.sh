#!/usr/bin/env bash

declare -a modules
modules=(
# Autocomplete
'all-the-package-names'
# Languages
'yarn'
'yo'
'prettier'

# Writing
'write-good'

# Web
'live-server'

# HTML
'htmlhint'
# CSS, SASS & LESS

# JavaScript
'npm-check-updates'
'gulp-cli'
'eslint'
# Express
'express-generator'
# Gatsby
# Removed because it was causing dependency errors, perhaps this can just use
# `yo` instead and then Gatsby as a project dependency.
# 'gatsby-cli'
# VS Code Extensions
'generator-code'

# Markdown
'markdownlint-cli'
'stylelint'

# VS Code
'vsce'
)
