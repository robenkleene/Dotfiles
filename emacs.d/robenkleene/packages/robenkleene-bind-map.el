;;; robenkleene-bind-map.el --- robenkleene-bind-map
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package bind-map
  :config
  (bind-map robenkleene/leader-map
    :keys ("C-c")
    :evil-keys ("SPC")
    :evil-states (normal motion))
  (bind-map robenkleene/emacs-lisp-leader-map
    :evil-keys ("\\")
    :major-modes (emacs-lisp-mode
                  lisp-interaction-mode))
  )

(provide 'robenkleene-bind-map)
;;; robenkleene-bind-map.el ends here
