;;; robenkleene-expand-region.el --- robenkleene-expand-region
;;; Commentary:
;;; Code:

(use-package expand-region
  :bind
  ("M-'" . er/expand-region)
  :init
  (defun rk/mark-markdown-link-title ()
    "Marks between tilde."
    (interactive)
    (search-backward "[" (line-beginning-position))
    (forward-char)
    (set-mark (point))
    (search-forward "]" (line-end-position))
    (backward-char)
    (exchange-point-and-mark))

  (defun rk/mark-markdown-link-url ()
    "Marks between tilde."
    (interactive)
    (search-backward "(" (line-beginning-position))
    (forward-char)
    (set-mark (point))
    (search-forward ")" (line-end-position))
    (backward-char)
    (exchange-point-and-mark))

  (defun rk/mark-markdown-inline-code ()
    "Marks between tilde."
    (interactive)
    (search-backward "`" (line-beginning-position))
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
                                rk/mark-markdown-link-title
                                rk/mark-markdown-link-url
                                ))))

  (add-hook 'markdown-mode-hook 'rk/add-markdown-mode-expansions)

  (defun rk/mark-org-inline-code ()
    "Marks between `~'."
    (interactive)
    (search-backward "~" (line-beginning-position))
    (forward-char)
    (set-mark (point))
    (search-forward "~" (line-end-position))
    (backward-char)
    (exchange-point-and-mark))

  (defun rk/add-org-mode-expansions ()
    (make-variable-buffer-local 'er/try-expand-list)
    (setq er/try-expand-list (append
                              er/try-expand-list
                              '(
                                rk/mark-org-inline-code
                                ))))

  (add-hook 'org-mode-hook 'rk/add-org-mode-expansions)

  )

(provide 'robenkleene-expand-region)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-expand-region.el ends here
