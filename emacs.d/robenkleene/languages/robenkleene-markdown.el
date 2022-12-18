;;; robenkleene-markdown.el --- robenkleene-markdown
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package markdown-mode
  :mode
  ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  ;; For Wiki Links
  ;; Doesn't support following links though
  ;; ("\\.\\(m\\(ark\\)?down\\|md\\)$" . gfm-mode)
  :bind
  (([remap markdown-enter-key] . robenkleene/markdown-enter-key))
  :init
  (setq flyspell-generic-check-word-predicate
        'robenkleene/flyspell-generic-textmode-verify)
  (setq markdown-enable-wiki-links t)

  :config
  ;; It might be possible to use this to change the default indent behavior when
  ;; making nested lists, but it doesn't appear to be easy without also removing
  ;; some other desirable behavior.
  ;; (setq markdown-indent-function 'indent-relative)
  (defun robenkleene/flyspell-generic-textmode-verify ()
    "Used for `flyspell-generic-check-word-predicate' in text modes."
    (let ((f (get-text-property (- (point) 1) 'face)))
      (not (memq f '(markdown-pre-face
                     markdown-inline-code-face
                     markdown-language-keyword-face)))))
  (defun robenkleene/markdown-enter-key ()
    "Follow links or enter."
    (interactive)
    (if (or (eolp) (bolp) (eq ?\[ (char-after)))
        (markdown-enter-key)
      (if (markdown-link-p)
          (markdown-follow-thing-at-point nil)
        (markdown-enter-key))
      )
    )
  (define-key markdown-mode-map (kbd "M-n")
    'next-error)
  (define-key markdown-mode-map (kbd "M-p")
    'previous-error)
  ;; Default move by paragraph doesn't skip over Markdown list items
  (define-key markdown-mode-map (kbd "M-}")
    'robenkleene/forward-block)
  (define-key markdown-mode-map (kbd "M-{")
    'robenkleene/backward-block)

  (add-hook 'markdown-mode-hook (lambda ()
                                  ;; (modify-syntax-entry ?_ "w")
                                  ;; (modify-syntax-entry ?- "w")
                                  ;; Wrap lines by automatically in Markdown documents
                                  (set 'truncate-lines nil)
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
  ;; Try `flyspell-prog-mode' to prevent spelling errors in Markdown code
  ;; blocks. This seems to disable spelling altogether: (add-hook
  ;; 'markdown-mode-hook 'flyspell-prog-mode)

  ;; Augment `markdown-calc-indents' to only returns multiples of `4'
  ;; Otherwise `markdown-mode' returns some multiples of `2', which is to align
  ;; hard-wrapped lines to bullet points, which we never want to do.
  (require 'seq)
  (advice-add 'markdown-calc-indents
              :filter-return
              #'(lambda (list)
                  (seq-filter
                   (lambda (x) (eq (% x 4) 0)) list)))
  )

(provide 'robenkleene-markdown)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-markdown.el ends here
