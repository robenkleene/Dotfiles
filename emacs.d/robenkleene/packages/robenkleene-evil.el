;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package evil
  :ensure t
  :bind (("C-c v" . evil-local-mode))
  :config
  (progn
    ;; Disable insert mode key map
    (setcdr evil-insert-state-map nil)
    ;; Re-enable esc
    (define-key evil-insert-state-map [escape] 'evil-normal-state)

    ;; Dired
    (define-key evil-motion-state-map "-" 'dired-jump)

    ;; Unimpaired Map
    (defvar robenkleene/unimpaired-next-map (make-keymap))
    (defvar robenkleene/unimpaired-previous-map (make-keymap))
    (define-key robenkleene/unimpaired-next-map (kbd "q") 'next-error)
    (define-key robenkleene/unimpaired-previous-map (kbd "q") 'previous-error)
    (define-key robenkleene/unimpaired-next-map (kbd "b") 'next-buffer)
    (define-key robenkleene/unimpaired-previous-map (kbd "b") 'previous-buffer)
    (define-key robenkleene/unimpaired-next-map (kbd "c") 'git-gutter:next-hunk)
    (define-key robenkleene/unimpaired-previous-map (kbd "c") 'git-gutter:previous-hunk)

    ;; Unimpaired Key
    (define-key evil-motion-state-map (kbd "[") robenkleene/unimpaired-previous-map)
    (define-key evil-motion-state-map (kbd "]") robenkleene/unimpaired-next-map)

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
    (define-key robenkleene/leader-map (kbd "l") 'swiper)
    (define-key robenkleene/leader-map (kbd "a") 'counsel-ag)

    ;; Leader Key
    ;; (define-key evil-motion-state-map (kbd "\\") robenkleene/leader-map)
    (define-key evil-motion-state-map (kbd "SPC") robenkleene/leader-map)

    
    )
  )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here


