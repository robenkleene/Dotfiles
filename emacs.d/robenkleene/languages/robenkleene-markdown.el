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
  :config
  ;; Block Movement
  (define-key markdown-mode-map (kbd "M-{")
              'rk/backward-block)
  (define-key markdown-mode-map (kbd "M-}")
              'rk/forward-block)
  ;; `markdown-mark-paragraph` will treat list items as individual paragraphs,
  ;; so just use the default `mark-paragraph`
  (define-key markdown-mode-map [remap mark-paragraph] nil)

  (add-hook 'markdown-mode-hook
            (lambda ()
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
