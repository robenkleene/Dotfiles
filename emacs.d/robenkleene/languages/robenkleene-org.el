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
  ;; Hide leading asterisks
  ;; This feels a bit fragile, but it makes the document much easier to scan and
  ;; understand quickly
  ;; (setq org-startup-indented t)

  (with-eval-after-load "org"
    ;; Disable `org-mode' keys that conflict with basic text editing
    ;; `(setq org-support-shift-select 'always)' handles some other bindings
    ;; Without the meta arrow keys to control outline, use `org-speed-commands'
    (define-key org-mode-map (kbd "M-<left>") nil)
    (define-key org-mode-map (kbd "M-<right>") nil)
    ;; These conflict with calendar related bindings, but the default `C-c C-<'
    ;; / `C-c C->' bindings aren't available in terminal Emacs
    (define-key org-mode-map (kbd "C-c <") 'org-promote-subtree)
    (define-key org-mode-map (kbd "C-c >") 'org-demote-subtree)
    (define-key org-mode-map (kbd "M-S-<left>") nil)
    (define-key org-mode-map (kbd "M-S-<right>") nil)
    (define-key org-mode-map (kbd "C-c C-u")
                'rk/org-up-heading)
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
  ;; Setting `org-startup-folded' seems to make drawers startup folded, this is
  ;; supposed to be the default (i.e., `org-hide-drawer-startup' is `t' by
  ;; default), but in practice it doesn't seem to work without this set to
  ;; `showall'
  (setq org-startup-folded 'showall)
  ;; Allow shift select bindings to work in some cases
  ;; The `t' option doesn't do enough to be worth it
  ;; (setq org-support-shift-select t)
  (setq org-support-shift-select 'always)
  ;; Default is `~/org`
  (setq org-directory "~/Documents/Text/Org/")
  (setq org-default-notes-file (concat org-directory "Inbox.org"))
  (setq org-agenda-files (list org-directory))

  ;; Set refile targets to all `org-agenda-files'
  (setq org-refile-targets
        '((nil :maxlevel . 1)
          (org-agenda-files :maxlevel . 1)))

  ;; Don't bookmark the current file with `org-capture'
  (setq org-capture-bookmark nil)

  ;; Allow `<s' to create a source code block
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist
               '("eshell-visual" . "SRC eshell :results output none :session eshell"))

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
  (setq org-return-follows-link 1)

  ;; Enable special keys when the point is at the first column (use `M-m')
  ;; This doesn't play nice with `org-indent-mode'.
  ;; (setq org-use-speed-commands t)

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

  ;; Open `org-agenda' in the window, this is beneficial because hitting enter
  ;; on an agenda item jumps to it in the same window
  (setq org-agenda-window-setup 'current-window)

  (setq org-support-shift-select 'always)

  (org-babel-do-load-languages 'org-babel-load-languages
                               '(
                                 (shell . t)
                                 (eshell . t)
                                 )
                               )
  (defvar org-outline-repeat-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "u") #'rk/org-up-heading)
      (define-key map (kbd "p") #'org-previous-visible-heading)
      (define-key map (kbd "n") #'org-next-visible-heading)
      (define-key map (kbd "b") #'org-backward-heading-same-level)
      (define-key map (kbd "f") #'org-forward-heading-same-level)
      map))
  (dolist (cmd '(
                 rk/org-up-heading
                 org-previous-visible-heading
                 org-next-visible-heading
                 org-backward-heading-same-level
                 org-forward-heading-same-level
                 ))
    (put cmd 'repeat-map 'org-outline-repeat-map))
  (defun rk/org-up-heading (&optional arg)
    "Go up a heading placeholder for repeat map."
    (interactive)
    (outline-up-heading 1)
    )

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
  (setq org-agenda-span 14
        org-agenda-start-on-weekday nil
        org-agenda-start-day "-3d")
  ;; (setq org-agenda-start-with-log-mode t)
  ;; (with-eval-after-load 'org-agenda
  ;;   (add-to-list 'org-agenda-custom-commands
  ;;                '("l" "Log agenda review" agenda ""
  ;;                  (
  ;;                   (org-agenda-log-mode t)
  ;;                   ))
  ;;                )
  ;;   )

  ;; Packages

  ;; (use-package org-modern
  ;;   :commands (global-org-modern-mode)
  ;;   :init
  ;;   (with-eval-after-load 'org (global-org-modern-mode))
  ;;   :config
  ;;   ;; The default third value in this list was a unicode character that
  ;;   ;; wouldn't display
  ;;   ;; This also simplifies to just use the filled triangle for the top-level
  ;;   ;; and the empty for all other levels, the other smaller triangles used by
  ;;   ;; default don't look as nice
  ;;   (setq org-modern-fold-stars
  ;;         '(("▶" . "▼") ("▷" . "▽")))
  ;;   )

  ;; Needs to always be available when killing
  (use-package org-rich-yank
    :demand t
    :bind (:map org-mode-map
                ("C-M-y" . org-rich-yank))
    ;; :config
    ;; ;; `org-rich-yank' inserts a new line after the paste, delete that
    ;; Disable this, it's sometimes resulting in deleting a real line of content
    ;; (defadvice org-rich-yank (after rk/org-rich-yank-cleanup activate)
    ;;   (delete-line)
    ;;   (backward-char)
    ;;   )

    )

  )

(provide 'robenkleene-org)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-org.el ends here
