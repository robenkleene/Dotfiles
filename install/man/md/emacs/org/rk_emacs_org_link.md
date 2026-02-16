- `org-store-link`, `C-c l` (suggested binding): Store a link that can be added with `C-c C-l`
- `C-c C-l`, `org-insert-link`: Add URL (just `C-y` after to paste from clipboard)
- `C-c C-l`: Edit the link (when the point is on a link)
- `C-c C-o`, `C-c C-d`: Open URL
- `C-c C-x C-p` / `C-c C-x C-n`: Goto previous / next link

# Notes

By default, `org-mode` uses a `<file>:<search>` format for links, which will not work well with most programming modes, this snippet replaces that with a `<file>:<line>` format.

```
(add-hook 'org-create-file-search-functions
          '(lambda ()
             (when (derived-mode-p 'prog-mode)
               (number-to-string (line-number-at-pos)))))
(add-hook 'org-execute-file-search-functions
          '(lambda (search-string)
             (when (derived-mode-p 'prog-mode)
               (goto-line (string-to-number search-string)))))
```
