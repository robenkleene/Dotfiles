;;; robenkleene-expand-region.el --- robenkleene-expand-region
;;; Commentary:
;;; Code:

(use-package expand-region
  :bind
  ("M-'" . er/expand-region)
  :init
  ;; Add support for Markdown inline code, and code blocks
  (defun rk/mark-markdown-inline-code ()
    "Marks one CSS declaration, eg. font-weight: bold;"
    (interactive)
    (search-backward-regexp "`" (line-beginning-position))
    (forward-char)
    (set-mark (point))
    (search-forward "`" (line-end-position))
    (backward-char)
    (exchange-point-and-mark))
  (defun rk/add-markdown-mode-expansions ()
    (make-variable-buffer-local 'er/try-expand-list)
    (setq er/try-expand-list (append
                              er/try-expand-list
                              '(
                                rk/mark-markdown-inline-code
                                ))))
  (add-hook 'markdown-mode-hook 'rk/add-markdown-mode-expansions)
  )

(provide 'robenkleene-expand-region)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-expand-region.el ends here
