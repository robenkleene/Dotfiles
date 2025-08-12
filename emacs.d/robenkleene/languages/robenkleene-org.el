;;; robenkleene-org.el --- robenkleene-org
;;; Commentary:
;;; Code:

(use-package org
  :bind
  ;; Recommended `org-mode' global bindings
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  :mode ("\\.org\\'" . org-mode)
  :init
  (with-eval-after-load "org"
    ;; Disable `org-mode' keys that conflict with basic text editing
    (define-key org-mode-map (kbd "M-<left>") nil)
    (define-key org-mode-map (kbd "M-<right>") nil)
    (define-key org-mode-map (kbd "M-S-<left>") nil)
    (define-key org-mode-map (kbd "M-S-<right>") nil)

    ;; These conflict with calendar related bindings, but the default `C-c C-<'
    ;; / `C-c C->' bindings aren't available in terminal Emacs
    (define-key org-mode-map (kbd "C-c <") 'org-promote-subtree)
    (define-key org-mode-map (kbd "C-c >") 'org-demote-subtree)

    ;; The default binding for this is `mark-defun' which isn't useful, this
    ;; binding will mark just the source code of a source block
    (define-key org-mode-map (kbd "C-M-h")
                'org-babel-mark-block)

    (define-key org-mode-map (kbd "M-{")
                'rk/backward-block)
    (define-key org-mode-map (kbd "M-}")
                'rk/forward-block)
    )
  :config
  ;; Enable special keys when the point is at the first column (use `M-m')
  ;; This doesn't play nice with `org-indent-mode'.
  ;; (setq org-use-speed-commands t)

  ;; `(setq org-support-shift-select 'always)' handles some conflicting editng
  ;; bindings
  ;; The `t' option doesn't do enough to be worth it
  ;; (setq org-support-shift-select t)
  (setq org-support-shift-select 'always)

  ;; Setting `org-startup-folded' seems to make drawers startup folded, this is
  ;; supposed to be the default (i.e., `org-hide-drawer-startup' is `t' by
  ;; default), but in practice it doesn't seem to work without this set to
  ;; `showall'
  (setq org-startup-folded 'showall)

  ;; Default is `~/org`
  ;; (setq org-default-notes-file (concat org-directory "Inbox.org"))
  ;; (setq org-agenda-files (list org-directory))

  ;; Set refile targets to all `org-agenda-files'
  (setq org-refile-targets
        '((nil :maxlevel . 1)
          (org-agenda-files :maxlevel . 1)))

  ;; Don't bookmark the current file with `org-capture'
  (setq org-capture-bookmark nil)

  ;; Simplify the default capture template to not include the date or a bookmark
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?")))

  ;; Code Blocks
  ;; Prevent any tampering with source code block indentation
  (setq org-src-preserve-indentation t)
  (setq org-edit-src-content-indentation 0)

  ;; Allow `<s' to create a source code block
  (require 'org-tempo)

  ;; Breaks choosing the date day with `shift' movement keys
  ;; (setq org-replace-disputed-keys t)

  ;; Add WIP mode
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

  ;; Always follow the current agenda item in the other window, doesn't work
  ;; nicely with evil
  ;; (setq org-agenda-start-with-follow-mode t)

  ;; Open `org-agenda' in the window, this is beneficial because hitting enter
  ;; on an agenda item jumps to it in the same window
  (setq org-agenda-window-setup 'current-window)

  (add-hook 'org-mode-hook
            (lambda ()
              ;; Set `~' as a string delimiter, this makes the `sexp'
              ;; commands (like `mark-sexp') work with backticks
              (modify-syntax-entry ?~ "\"")
              )
            )

  (add-hook 'org-agenda-mode-hook
            (lambda ()
              ;; Wrap lines
              (setq-local truncate-lines nil)
              )
            )

  ;; Agenda
  ;; By default, agenda only shows one week
  (setq org-agenda-span 28)

  )

(provide 'robenkleene-org)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-org.el ends here
