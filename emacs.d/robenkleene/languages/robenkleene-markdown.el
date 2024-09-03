;;; robenkleene-markdown.el --- robenkleene-markdown
;;; Commentary:
;;; Code:

(use-package markdown-mode
  :mode
  ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  ;; For Wiki Links
  ;; Doesn't support following links though
  ;; ("\\.\\(m\\(ark\\)?down\\|md\\)$" . gfm-mode)
  :bind
  (([remap markdown-enter-key] . rk/markdown-enter-key))
  :init
  ;; (setq markdown-enable-wiki-links t)
  ;; Enable Latex math surrounded by `$' in Markdown
  (setq markdown-enable-math t)
  ;; Show a flat list of headers in `imenu', instead of a nested list
  ;; (The nested list means you have to choose the top heading, then a more
  ;; specific heading)
  ;; With `markdown-nested-imenu-heading-index' set to `nil', long documents
  ;; with lots of subheaders become impossible to navigate, with it enabled, the
  ;; menu works nicely with `consult-imenu' with headers prefixed with their
  ;; parent header
  ;; (setq markdown-nested-imenu-heading-index nil)
  ;; Enable syntax highlighting for code blocks
  (setq markdown-fontify-code-blocks-natively t)
  :config
  ;; Performance Tweak
  ;; This disables italics from `*', but that was causing slowness with input in
  ;; large Markdown files
  ;; (Probably due to parsing `*' for lists vs. italic)
  ;; You can test this by running `profile-start', then input, then
  ;; `profile-report'. It seems to only appear when editing heirarchical lists
  ;; Re-enabling this, just start breaking down huge markdown lists, because
  ;; they make Emacs slow no matter what
  ;; (defconst markdown-regex-italic
  ;;   "\\(?:^\\|[^\\]\\)\\(?1:\\(?2:[_]\\)\\(?3:[^ \n\t\\]\\|[^ \n\t]\\(?:.\\|\n[^\n]\\)[^\\ ]\\)\\(?4:\\2\\)\\)")
  ;; (defconst markdown-regex-gfm-italic
  ;;   "\\(?:^\\|[^\\]\\)\\(?1:\\(?2:[_]\\)\\(?3:[^ \\]\\2\\|[^ ]\\(?:.\\|\n[^\n]\\)\\)\\(?4:\\2\\)\\)")

  ;; It might be possible to use this to change the default indent behavior when
  ;; making nested lists, but it doesn't appear to be easy without also removing
  ;; some other desirable behavior.
  ;; (setq markdown-indent-function 'indent-relative)

  (defun rk/markdown-enter-key ()
    "Follow links or enter."
    (interactive)
    (if (or (eolp) (bolp) (eq ?\[ (char-after)))
        (markdown-enter-key)
      (if (markdown-link-p)
          (markdown-follow-thing-at-point nil)
        (markdown-enter-key))
      )
    )
  (define-key markdown-mode-map (kbd "M-{")
              'rk/backward-block)
  (define-key markdown-mode-map (kbd "M-}")
              'rk/forward-block)
  (define-key markdown-mode-map (kbd "C-M-h")
              'rk/mark-markdown-code-block)

  ;; The default commands treat each list item as a single paragraph. These
  ;; commands jump over entire lists This one still behaves weird in some cases,
  ;; e.g., when trying to jump over an open code block (define-key
  ;; markdown-mode-map (kbd "M-{") 'markdown-backward-block) (define-key
  ;; markdown-mode-map (kbd "M-}") 'markdown-forward-block)
  ;; `markdown-mark-block' doesn't support `M-- M-h' shrink a selection
  ;; (define-key markdown-mode-map (kbd "M-h") 'markdown-mark-block) The default
  ;; `markdown-mark-paragraph' doesn't support `M-- M-h' either, so just use the
  ;; default
  (define-key markdown-mode-map [remap mark-paragraph] nil)

  (defvar markdown-outline-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "u") #'markdown-outline-up)
      (define-key map (kbd "p") #'markdown-outline-previous)
      (define-key map (kbd "n") #'markdown-outline-next)
      (define-key map (kbd "b") #'markdown-outline-previous-same-level)
      (define-key map (kbd "f") #'markdown-outline-next-same-level)
      map))
  (dolist (cmd '(
                 markdown-outline-up
                 markdown-outline-previous
                 markdown-outline-next
                 markdown-outline-previous-same-level
                 markdown-outline-next-same-level
                 ))
    (put cmd 'repeat-map 'markdown-outline-repeat-map))

  ;; After jumping to a link, move one character right so `<return>' will open
  ;; the link
  (defadvice markdown-next-link (after rk/markdown-next-link activate)
    (forward-char))
  (defadvice markdown-previous-link (after rk/markdown-previous-link activate)
    (forward-char))

  (add-hook 'markdown-mode-hook
            (lambda ()
              ;; Use blank lines to indicate paragraphs
              (setq-local paragraph-start "[[:blank:]]*\n")
              (setq-local paragraph-separate "[[:blank:]]*$")
              ;; Set backtick as a string delimiter, this makes the `sexp'
              ;; commands (like `mark-sexp') work with backticks
              (modify-syntax-entry ?` "\"")
              ;; Set `"' as a string delimiter
              (modify-syntax-entry ?\" "\"")
              ;; (modify-syntax-entry ?_ "w")
              ;; (modify-syntax-entry ?- "w")
              ;; Automatically auto-save markdown files
              ;; This doesn't work
              ;; Turn on auto-saving
              ;; (set
              ;;  (make-local-variable
              ;;   'auto-save-visited-file-name)
              ;;  t)
              ;; (setq-local auto-save-default t)
              ;; (auto-save-mode)
              )
            )

  ;; Augment `markdown-calc-indents' to only returns multiples of `4'
  ;; Otherwise `markdown-mode' returns some multiples of `2', which is to align
  ;; hard-wrapped lines to bullet points, which we never want to do.
  (require 'seq)
  (advice-add 'markdown-calc-indents
              :filter-return
              #'(lambda (list)
                  (seq-filter
                   (lambda (x) (eq (% x 4) 0)) list))))

(provide 'robenkleene-markdown)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-markdown.el ends here
