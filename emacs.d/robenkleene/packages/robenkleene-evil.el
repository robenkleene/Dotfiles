;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(defvar evil)
(use-package evil
  :ensure t
  :init
  (progn
    (evil-mode 1)
    ;; Disable Evil's integrations
    (defun evil-make-overriding-map (keymap &optional state copy)
      "No-op."
      )
    (defmacro evil-add-hjkl-bindings (keymap &optional state &rest bindings)
      "No-op."
      )


    ;;; Basic
    
    ;; Disable insert mode key map
    (setcdr evil-insert-state-map nil)
    ;; Re-enable esc
    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    
    ;; hl-line-mode matches evil mode
    (add-hook 'evil-normal-state-entry-hook (lambda () (setq global-hl-line-mode t)))
    (add-hook 'evil-motion-state-entry-hook (lambda () (setq global-hl-line-mode t)))
    (add-hook 'evil-insert-state-entry-hook (lambda () (setq global-hl-line-mode nil)))
    (add-hook 'evil-visual-state-entry-hook (lambda () (setq global-hl-line-mode nil)))


    ;;; Mode Special Treatment

    ;; Curate list of `evil-motion-state-modes'
    (setq evil-emacs-state-modes (remove 'package-menu-mode evil-emacs-state-modes))
    (add-to-list 'evil-motion-state-modes 'package-menu-mode)

    ;; Magit
    ;; (setq evil-emacs-state-modes (remove 'magit-status-mode evil-emacs-state-modes))
    ;; (add-to-list 'evil-motion-state-modes 'magit-status-mode)
    ;; TODO: Write a macro that evilifies a list of keymaps, this should make all the
    ;; maps have their bindings replaced by an evil mode map
    ;; To get magit working again, I need to prevent these maps from overriding evil:
      ;; (spacemacs|evilify-map magit-tag-section-map)
      ;; (spacemacs|evilify-map magit-untracked-section-map)
      ;; (spacemacs|evilify-map magit-branch-section-map)
      ;; (spacemacs|evilify-map magit-remote-section-map)
      ;; (spacemacs|evilify-map magit-file-section-map)
      ;; (spacemacs|evilify-map magit-hunk-section-map)
      ;; (spacemacs|evilify-map magit-unstaged-section-map)
      ;; (spacemacs|evilify-map magit-staged-section-map)
      ;; (spacemacs|evilify-map magit-commit-section-map)
      ;; (spacemacs|evilify-map magit-module-commit-section-map)
      ;; (spacemacs|evilify-map magit-unpulled-section-map)
      ;; (spacemacs|evilify-map magit-unpushed-section-map)
      ;; (spacemacs|evilify-map magit-stashes-section-map)
      ;; (spacemacs|evilify-map magit-stash-section-map)
;; (evil-set-initial-state 'magit-mode 'normal)
;; (evil-set-initial-state 'magit-status-mode 'normal)
;; (evil-set-initial-state 'magit-diff-mode 'normal)
;; (evil-set-initial-state 'magit-log-mode 'normal)
;; (evil-define-key 'normal magit-mode-map
;;     "j" 'magit-goto-next-section
;;     "k" 'magit-goto-previous-section)
;; (evil-define-key 'normal magit-log-mode-map
;;     "j" 'magit-goto-next-section
;;     "k" 'magit-goto-previous-section)
;; (evil-define-key 'normal magit-diff-mode-map
;;     "j" 'magit-goto-next-section
;;     "k" 'magit-goto-previous-section)

    
    ;;; Bindings

    ;; Let default bindings for mode poke through
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "TAB") nil)

    ;; Dired
    (define-key evil-motion-state-map "-" 'dired-jump)

    ;; ;; Helm Swoop
    ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)


    ;;; Unimpaired

    ;; Unimpaired Map
    (defvar robenkleene/unimpaired-next-map (make-keymap))
    (defvar robenkleene/unimpaired-previous-map (make-keymap))
    (define-key robenkleene/unimpaired-next-map (kbd "q") 'next-error)
    (define-key robenkleene/unimpaired-previous-map (kbd "q") 'previous-error)
    (define-key robenkleene/unimpaired-next-map (kbd "b") 'next-buffer)
    (define-key robenkleene/unimpaired-previous-map (kbd "b") 'previous-buffer)

    ;; Unimpaired Key
    (define-key evil-motion-state-map (kbd "[") robenkleene/unimpaired-previous-map)
    (define-key evil-motion-state-map (kbd "]") robenkleene/unimpaired-next-map)


    ;;; Open

    ;; Open Map
    (defvar robenkleene/open-map (make-keymap))
    (define-key robenkleene/open-map (kbd "i") (lambda() (interactive) (find-file "~/.emacs.d/robenkleene/robenkleene.el")))
    (define-key robenkleene/open-map (kbd "p") (lambda() (interactive) (find-file "~/.emacs.d/elpa/")))


    ;;; Leader

    ;; Leader Map
    (defvar robenkleene/leader-map (make-keymap))
    (define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
    (define-key robenkleene/leader-map (kbd "t") 'robenkleene/open-terminal-window)
    (define-key robenkleene/leader-map (kbd "f") 'robenkleene/open-finder-window)
    (define-key robenkleene/leader-map (kbd "F") 'helm-find-files)
    (define-key robenkleene/leader-map (kbd "a") 'helm-do-ag)
    (define-key robenkleene/leader-map (kbd "o") robenkleene/open-map)
    (define-key robenkleene/leader-map (kbd "b") 'helm-buffers-list)
    (define-key robenkleene/leader-map (kbd "g") 'magit-status)
    (define-key robenkleene/leader-map (kbd "h") 'helm-apropos)

    ;; Leader Key
    (define-key evil-motion-state-map (kbd "\\") robenkleene/leader-map)

    )
  )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here
