;;; robenkleene-evil-magit.el --- robenkleene-evil-magit
;;; Commentary:
;;; Code:

(defvar evil-emacs-state-modes)
(eval-after-load "magit"
  '(progn

     (setq evil-emacs-state-modes (remove 'magit-status-mode evil-emacs-state-modes))
     (setq evil-emacs-state-modes (remove 'magit-diff-mode evil-emacs-state-modes))
     (setq evil-emacs-state-modes (remove 'magit-revision-mode evil-emacs-state-modes))
     (setq evil-emacs-state-modes (remove 'magit-stash-mode evil-emacs-state-modes))
     (setq evil-emacs-state-modes (remove 'magit-stashes-mode evil-emacs-state-modes))
    
     (defvar magit-mode-map)
     (evil-declare-key 'normal magit-mode-map (kbd "s") 'magit-stage)
     (evil-declare-key 'normal magit-mode-map (kbd "u") 'magit-unstage)
     (evil-declare-key 'normal magit-mode-map (kbd "q") 'magit-mode-bury-buffer)
     (evil-declare-key 'normal magit-mode-map (kbd "c") 'magit-commit-popup)
     (evil-declare-key 'normal magit-mode-map (kbd "P") 'magit-push-popup)

     ;; TODO: A better key for this would be `R' from Vim or `g' from Tig.
     ;; But both of those have complications, `r' overrides the rebase menu
     ;; but that can be accessed by entering insert mode
     (evil-declare-key 'normal magit-mode-map (kbd "r") 'magit-refresh)

     ;; List of maps that override `k' key
     ;; Found by grepping magit directory for `"k"'
     (defvar magit-file-section-map)
     (defvar magit-hunk-section-map)
     (defvar magit-unstaged-section-map)
     (defvar magit-staged-section-map)
     (defvar magit-stashes-section-map)
     (defvar magit-untracked-section-map)
     (defvar magit-branch-section-map)
     (defvar magit-remote-section-map)
     (defvar magit-tag-section-map)

     (define-key magit-file-section-map "K" 'magit-discard)
     (define-key magit-file-section-map "k" nil)
     (define-key magit-hunk-section-map "K" 'magit-discard)
     (define-key magit-hunk-section-map "k" nil)
     (define-key magit-unstaged-section-map "k" nil)
     (define-key magit-unstaged-section-map "K" 'magit-discard)
     (define-key magit-staged-section-map "K" 'magit-discard)
     (define-key magit-staged-section-map "k" nil)
     (define-key magit-stashes-section-map "K" 'magit-stash-clear)
     (define-key magit-stashes-section-map "k" nil)
     (define-key magit-untracked-section-map "K" 'magit-discard)
     (define-key magit-untracked-section-map "k" nil)
     (define-key magit-branch-section-map "K" 'magit-branch-delete)
     (define-key magit-branch-section-map "k" nil)
     (define-key magit-remote-section-map "K" 'magit-remote-remove)
     (define-key magit-remote-section-map "k" nil)
     (define-key magit-tag-section-map "k" nil)
     (define-key magit-tag-section-map "K" 'magit-tag-delete)
     )
  )

(provide 'robenkleene-evil-magit)
;;; robenkleene-evil-magit.el ends here
