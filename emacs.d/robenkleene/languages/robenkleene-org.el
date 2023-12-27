;;; robenkleene-org.el --- robenkleene-org
;;; Commentary:
;;; Code:

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :commands (org-store-link)
  :config
  ;; Breaks choosing the date day with `shift' movement keys
  ;; (setq org-replace-disputed-keys t)
  (setq org-startup-indented t)
  ;; (setq org-todo-keywords '("TODO" "WIP" "DONE"))
  ;; Disable spell check in code blocks
  (defadvice org-mode-flyspell-verify
      (after org-mode-flyspell-verify-hack activate)
    (let ((rlt ad-return-value)
          (begin-regexp "^[ \t]*#\\+begin_\\(src\\|html\\|latex\\)")
          (end-regexp "^[ \t]*#\\+end_\\(src\\|html\\|latex\\)")
          old-flag
          b e)
      (when ad-return-value
        (save-excursion
          (setq old-flag case-fold-search)
          (setq case-fold-search t)
          (setq b (re-search-backward begin-regexp nil t))
          (if b (setq e (re-search-forward end-regexp nil t)))
          (setq case-fold-search old-flag))
        (if (and b e (< (point) e)) (setq rlt nil)))
      (setq ad-return-value rlt)))

  (setq org-deadline-warning-days 0)
  (setq org-return-follows-link 1)

  ;; Always follow the current agenda item in the other window, doesn't work
  ;; nicely with evil
  ;; (setq org-agenda-start-with-follow-mode t)

  (setq org-agenda-window-setup 'current-window)
  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-c a") 'org-agenda-list)
    (define-key org-mode-map (kbd "M-<left>") nil)
    (define-key org-mode-map (kbd "M-<right>") nil)
    )

  ;; Agenda
  (setq org-agenda-span 10
        org-agenda-start-on-weekday nil
        org-agenda-start-day "-3d")
  (setq org-agenda-start-with-log-mode t)
  (with-eval-after-load 'org-agenda
    (add-to-list 'org-agenda-custom-commands
                 '("l" "Log agenda review" agenda ""
                   (
                    (org-agenda-log-mode t)
                    ))
                 )
    )

  ;; Packages

  (use-package org-modern
    :commands (global-org-modern-mode)
    :init
    (with-eval-after-load 'org (global-org-modern-mode))
    :config
    (setq org-modern-hide-stars nil)
    )
  )

(provide 'robenkleene-org)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-org.el ends here
