;;; robenkleene-org.el --- robenkleene-org
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :init
  (setq org-directory "~/Documents/Text/Notes/Todo")
  (setq org-default-notes-file (concat org-directory "/todo.org"))
  (setq org-agenda-files (list org-directory))
  (defun org ()
    (interactive)
    "Switch to `org-default-notes-file' file."
    (rk/safe-find-file org-default-notes-file)
    )
  :config
  ;; Breaks choosing the date day with `shift' movement keys
  ;; (setq org-replace-disputed-keys t)
  (setq org-startup-indented t)
  (setq org-todo-keywords '("TODO" "WIP" "DONE"))
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

  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-c a") 'org-agenda-list)
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
