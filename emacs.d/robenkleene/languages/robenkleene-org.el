;;; robenkleene-org.el --- robenkleene-org
;;; Commentary:
;;; Code:

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :commands (org-store-link)
  :config
  ;; Allow `<s' to create a source code block
  (require 'org-tempo)

  ;; Breaks choosing the date day with `shift' movement keys
  ;; (setq org-replace-disputed-keys t)

  ;; Hide leading asterisks
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

  ;; Enable special keys when the point is right after the asterisk
  (setq org-use-speed-commands t)

  (defun org-remove-link ()
    "Replace an org link by its description or if empty its address"
    (interactive)
    (if (org-in-regexp org-link-bracket-re 1)
        (save-excursion
          (let ((remove (list (match-beginning 0) (match-end 0)))
                (description
                 (if (match-end 2) 
                     (org-match-string-no-properties 2)
                   (org-match-string-no-properties 1))))
            (apply 'delete-region remove)
            (insert description)))))

  ;; Always follow the current agenda item in the other window, doesn't work
  ;; nicely with evil
  ;; (setq org-agenda-start-with-follow-mode t)

  (setq org-agenda-window-setup 'current-window)
  (with-eval-after-load 'org
    ;; (define-key org-mode-map (kbd "C-c a") 'org-agenda-list)
    ;; Disable `org-mode' keys that conflict with basic text editing
    (define-key org-mode-map (kbd "M-<left>") nil)
    (define-key org-mode-map (kbd "M-<right>") nil)
    (define-key org-mode-map (kbd "M-S-<left>") nil)
    (define-key org-mode-map (kbd "M-S-<right>") nil)
    (define-key org-mode-map (kbd "S-<down>") nil)
    (define-key org-mode-map (kbd "S-<up>") nil)
    (define-key org-mode-map (kbd "S-<left>") nil)
    (define-key org-mode-map (kbd "S-<right>") nil)
    ;; Navigating links
    ;; (define-key org-mode-map (kbd "M-n") 'org-next-link)
    ;; (define-key org-mode-map (kbd "M-p") 'org-previous-link)

    (defvar org-link-repeat-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "n") #'org-next-link)
        (define-key map (kbd "p") #'org-previous-link)
        map))

    (dolist (cmd '(org-next-link org-previous-link))
      (put cmd 'repeat-map 'org-link-repeat-map))

    )

  ;; Use line numbers when creating links for some modes
  (add-hook 'org-create-file-search-functions
            #'(lambda ()
                (when (derived-mode-p 'prog-mode)
                  (number-to-string (line-number-at-pos)))))
  (add-hook 'org-execute-file-search-functions
            #'(lambda (search-string)
                (when (derived-mode-p 'prog-mode)
                  (goto-line (string-to-number search-string)))))
  ;; Open links in current window
  ;; (add-to-list 'org-link-frame-setup '(file . find-file))

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
