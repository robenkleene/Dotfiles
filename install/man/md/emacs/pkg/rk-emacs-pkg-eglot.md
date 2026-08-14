- `C-h .`: Show diagnostics at point
- `eglot-list-connections`: Show attached LSP

# Project Management

`eglot` uses `Project.el` to find the root directory of a project, which in turn looks for the version control root.

For projects that have a different root, the workaround is to add a `.project.el` file to the root, a custom `project-find-functions` can then look for this method.

# Troubleshooting

- `eglot-events-buffer`
