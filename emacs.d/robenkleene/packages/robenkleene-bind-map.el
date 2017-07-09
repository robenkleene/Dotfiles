;;; robenkleene-bind-map.el --- robenkleene-bind-map
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package bind-map
  :ensure t
  :config
  (bind-map robenkleene/leader-map
    :keys ("C-c")
    :evil-keys ("SPC")
    :evil-states (normal motion))
  (bind-map robenkleene/emacs-lisp-leader-map
    :evil-keys ("\\")
    :major-modes (emacs-lisp-mode
                  lisp-interaction-mode))

  ;; Open Map
  (defvar robenkleene/open-map (make-keymap))
  (define-key robenkleene/open-map (kbd "i") (lambda() (interactive) (find-file "~/.emacs.d/robenkleene/robenkleene.el")))

  ;; Leader Map
  (defvar robenkleene/leader-map (make-keymap))
  (define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
  (define-key robenkleene/leader-map (kbd "t") 'robenkleene/open-terminal-window)
  (define-key robenkleene/leader-map (kbd "R") 'robenkleene/reveal-in-finder)
  (define-key robenkleene/leader-map (kbd "E") 'robenkleene/external-editor)
  (define-key robenkleene/leader-map (kbd "o") robenkleene/open-map)
  (define-key robenkleene/leader-map (kbd "b") 'ido-switch-buffer)
  )

(provide 'robenkleene-bind-map)
;;; robenkleene-bind-map.el ends here
