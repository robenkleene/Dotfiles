;;; robenkleene-markdown.el --- robenkleene-markdown
;;; Commentary:
;;; Code:

(use-package markdown-mode
  :mode
  ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :init
  ;; Enable Latex math surrounded by `$' in Markdown
  (setq markdown-enable-math t)
  ;; Show a flat list of headers in `imenu', instead of a nested list
  ;; (The nested list means you have to choose the top heading, then a more
  ;; specific heading)
  ;; With `markdown-nested-imenu-heading-index' set to `nil', long documents
  ;; with lots of subheaders become impossible to navigate, with it enabled, the
  ;; menu works nicely with `consult-imenu' with headers prefixed with their
  ;; parent header
  (setq markdown-nested-imenu-heading-index nil)
  ;; Disable this, use `C-c C-o', which is consistent with `org-mode'
  ;; :bind
  ;; (([remap markdown-enter-key] . rk/markdown-enter-key))
  :config
  ;; Block Movement
  ;; Replace `backward-paragrah' / `forward-paragrah' (which have a `M-{')
  (define-key markdown-mode-map (kbd "M-{")
              'rk/backward-block)
  (define-key markdown-mode-map (kbd "M-}")
              'rk/forward-block)
  (define-key markdown-mode-map (kbd "C-M-h")
              'rk/mark-markdown-code-block)
  ;; `markdown-mark-paragraph` will treat list items as individual paragraphs,
  ;; so just use the default `mark-paragraph`
  (define-key markdown-mode-map [remap mark-paragraph] nil)

  ;; Allow following links with return, without this, the best built-in binding
  ;; to follow links is `C-c C-d' or `C-c C-o'
  ;; (defun rk/markdown-enter-key ()
  ;;   "Follow links or enter."
  ;;   (interactive)
  ;;   (if (or (eolp) (bolp) (eq ?\[ (char-after)))
  ;;       (markdown-enter-key)
  ;;     (if (markdown-link-p)
  ;;         (markdown-follow-thing-at-point nil)
  ;;       (markdown-enter-key))
  ;;     )
  ;;   )

  (defun rk/mark-markdown-code-block ()
    "Marks between tilde."
    (interactive)
    (end-of-line)
    (search-backward "```")
    (next-line)
    (beginning-of-line)
    (set-mark (point))
    (search-forward "```")
    (previous-line)
    (end-of-line)
    (exchange-point-and-mark)
    )

  (add-hook 'markdown-mode-hook
            (lambda ()
              ;; Use blank lines to indicate paragraphs
              ;; Using `mark-paragraph` to treat a block of lists as a single
              ;; paragraph won't work without this
              (setq-local paragraph-start "[[:blank:]]*\n")
              (setq-local paragraph-separate "[[:blank:]]*$")

              ;; Set backtick as a string delimiter, this makes the `sexp'
              ;; commands (like `mark-sexp') work with backticks
              (modify-syntax-entry ?` "\"")
              ;; Set `"' as a string delimiter
              (modify-syntax-entry ?\" "\"")
              ;; Set `*' as a string delimiter
              (modify-syntax-entry ?* "\"")
              )
            )

  )

(provide 'robenkleene-markdown)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-markdown.el ends here
