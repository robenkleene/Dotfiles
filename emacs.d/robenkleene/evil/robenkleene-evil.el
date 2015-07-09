;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package evil
  :ensure t
  :config
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

    ;; Always switch to initial evil state when switching to a buffer
    (defvar previous-buffer)
    (defvar next-buffer)
    (defvar other-window)
    (defvar select-window)
    (defvar switch-to-buffer)
    (robenkleene/advice-after-evil-initial-state previous-buffer)
    (robenkleene/advice-after-evil-initial-state next-buffer)
    (robenkleene/advice-after-evil-initial-state other-window)
    (robenkleene/advice-after-evil-initial-state select-window)
    (robenkleene/advice-after-evil-initial-state switch-to-buffer)

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
    ;; Set insert mode when entering evil mode
    ;; (add-hook 'git-commit-mode-hook 'evil-insert-state)


    ;;; Curate list of `evil-motion-state-modes'
    ;; Motion State Modes
    (setq evil-emacs-state-modes (remove 'package-menu-mode evil-emacs-state-modes))
    (add-to-list 'evil-motion-state-modes 'package-menu-mode)
    ;; Insert State Modes
    (setq evil-emacs-state-modes (remove 'git-commit-mode evil-emacs-state-modes))
    (setq evil-insert-state-modes (remove 'shell-mode evil-insert-state-modes))
    (setq evil-insert-state-modes (remove 'eshell-mode evil-insert-state-modes))

    ;;; Bindings

    ;; Let default bindings for mode poke through
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "TAB") nil)

    ;; Dired
    (define-key evil-motion-state-map "-" 'dired-jump)
    ;; This is unnecessary when the above is added to the evil-motion-state-map
    ;; (defvar dired-mode-map)
    ;; (define-key dired-mode-map (kbd "-") 'dired-up-directory)

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
    (define-key robenkleene/open-map (kbd "s") (lambda() (interactive) (find-file "~/Development/Scratch/Temp/")))


    ;;; Leader

    ;; Leader Map
    (defvar robenkleene/leader-map (make-keymap))
    (define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
    (define-key robenkleene/leader-map (kbd "t") 'robenkleene/open-terminal-window)
    (define-key robenkleene/leader-map (kbd "r") 'robenkleene/reveal-in-finder)
    (define-key robenkleene/leader-map (kbd "e") 'robenkleene/external-editor)
    (define-key robenkleene/leader-map (kbd "F") 'helm-find-files)
    (define-key robenkleene/leader-map (kbd "f") 'robenkleene/best-find-file)
    (define-key robenkleene/leader-map (kbd "a") 'robenkleene/best-ag)
    (define-key robenkleene/leader-map (kbd "A") 'helm-do-ag)
    (define-key robenkleene/leader-map (kbd "o") robenkleene/open-map)
    (define-key robenkleene/leader-map (kbd "\\") 'helm-buffers-list)
    (define-key robenkleene/leader-map (kbd "b") 'helm-buffers-list)
    (define-key robenkleene/leader-map (kbd "g") 'magit-status)
    (define-key robenkleene/leader-map (kbd "h") 'helm-resume)
    (define-key robenkleene/leader-map (kbd "c") 'robenkleene/other-window-shell)

    ;; Leader Key
    (define-key evil-motion-state-map (kbd "\\") robenkleene/leader-map)

    )
  )
(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here
