;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package evil
  :ensure t
  :config
  ;; Disable insert mode key map
  (setcdr evil-insert-state-map nil)
  ;; Re-enable Esc
  (define-key evil-insert-state-map [escape] 'evil-normal-state)

  ;; Window Switching
  (define-key evil-motion-state-map (kbd "M-h") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "M-k") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "M-j") 'evil-window-down)
  (define-key evil-motion-state-map (kbd "M-l") 'evil-window-right)

  (require 'robenkleene-evil-unimpaired-map)

  ;; Dired
  (define-key evil-motion-state-map "-" 'dired-jump)
  
  ;; Open Map
  (defvar robenkleene/open-map (make-keymap))
  (define-key robenkleene/open-map (kbd "i") (lambda() (interactive) (find-file "~/.emacs.d/robenkleene/robenkleene.el")))

  ;; Leader Map
  (defvar robenkleene/leader-map (make-keymap))
  (define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
  (define-key robenkleene/leader-map (kbd "t") 'robenkleene/open-terminal-window)
  (define-key robenkleene/leader-map (kbd "r") 'robenkleene/reveal-in-finder)
  (define-key robenkleene/leader-map (kbd "e") 'robenkleene/external-editor)
  (define-key robenkleene/leader-map (kbd "o") robenkleene/open-map)

  (define-key robenkleene/leader-map (kbd "f") '(lambda () (interactive)
                                                  (projectile-find-file-in-directory default-directory)))
  (define-key robenkleene/leader-map (kbd "a") 'counsel-ag)

  ;; Leader Key
  ;; (define-key evil-motion-state-map (kbd "\\") robenkleene/leader-map)
  (define-key evil-motion-state-map (kbd "SPC") robenkleene/leader-map)
  (evil-mode 1)
  
  )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here


