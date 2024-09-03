;;; robenkleene-expand-region.el --- robenkleene-expand-region
;;; Commentary:
;;; Code:

(use-package expand-region
  :bind (
         ("M-'" . er/expand-region)
         )
  :init
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

  (defun rk/mark-markdown-link-title-outer ()
    "Marks between tilde."
    (interactive)
    (forward-char)
    (search-backward "[" (line-beginning-position))
    (set-mark (point))
    (search-forward "]" (line-end-position))
    (exchange-point-and-mark))

  (defun rk/mark-markdown-link-title-inner ()
    "Marks between tilde."
    (interactive)
    (search-backward "[" (line-beginning-position))
    (forward-char)
    (set-mark (point))
    (search-forward "]" (line-end-position))
    (backward-char)
    (exchange-point-and-mark))

  (defun rk/mark-markdown-link-url-outer ()
    "Marks between tilde."
    (interactive)
    (forward-char)
    (search-backward "(" (line-beginning-position))
    (set-mark (point))
    (search-forward ")" (line-end-position))
    (exchange-point-and-mark))

  (defun rk/mark-markdown-link-url-inner ()
    "Marks between tilde."
    (interactive)
    (search-backward "(" (line-beginning-position))
    (forward-char)
    (set-mark (point))
    (search-forward ")" (line-end-position))
    (backward-char)
    (exchange-point-and-mark))

  (defun rk/mark-markdown-inline-code-outer ()
    "Marks between tilde."
    (interactive)
    (forward-char)
    (search-backward "`" (line-beginning-position))
    (set-mark (point))
    (search-forward "`" (line-end-position))
    (exchange-point-and-mark))

  (defun rk/mark-markdown-inline-code-inner ()
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
                                rk/mark-markdown-inline-code-outer
                                rk/mark-markdown-inline-code-innter
                                rk/mark-markdown-link-title-outer
                                rk/mark-markdown-link-title-innter
                                rk/mark-markdown-link-url-outer
                                rk/mark-markdown-link-url-inner
                                rk/mark-markdown-code-block
                                ))))

  (add-hook 'markdown-mode-hook 'rk/add-markdown-mode-expansions)

  (defun rk/mark-org-link ()
    "Marks between `[['."
    (interactive)
    (search-backward "\[\[" (line-beginning-position))
    (set-mark (point))
    (search-forward "\]\]" (line-end-position))
    (exchange-point-and-mark))

  (defun rk/mark-org-inline-code-inner ()
    "Marks between `~'."
    (interactive)
    (search-backward "~" (line-beginning-position))
    (forward-char)
    (set-mark (point))
    (search-forward "~" (line-end-position))
    (backward-char)
    (exchange-point-and-mark))

  (defun rk/mark-org-inline-code-outer ()
    "Marks between `~'."
    (interactive)
    (forward-char)
    (search-backward "~" (line-beginning-position))
    (set-mark (point))
    (search-forward "~" (line-end-position))
    (exchange-point-and-mark))

  (defun rk/add-org-mode-expansions ()
    (make-variable-buffer-local 'er/try-expand-list)
    (setq er/try-expand-list (append
                              er/try-expand-list
                              '(
                                rk/mark-org-inline-code-inner
                                rk/mark-org-inline-code-outer
                                rk/mark-org-link
                                ))))

  (add-hook 'org-mode-hook 'rk/add-org-mode-expansions)

  )

(provide 'robenkleene-expand-region)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-expand-region.el ends here
