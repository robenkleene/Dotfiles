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
  (define-key robenkleene/leader-map (kbd "b") 'helm-buffers-list)
  (define-key robenkleene/leader-map (kbd "f") 'projectile-find-file-in-directory)
  ;; (define-key robenkleene/leader-map (kbd "f") '(lambda () (interactive)
  ;;                                                 (projectile-find-file-in-directory default-directory)))
  (define-key robenkleene/leader-map (kbd "c") 'projectile-find-dir)
  (define-key robenkleene/leader-map (kbd "a") 'helm-do-ag)
  ;; (define-key robenkleene/leader-map (kbd "a") '(lambda () (interactive)
  ;;                                                 (helm-do-ag default-directory)))

  ;; Leader Key
  )

(provide 'robenkleene-bind-map)
;;; robenkleene-bind-map.el ends here
