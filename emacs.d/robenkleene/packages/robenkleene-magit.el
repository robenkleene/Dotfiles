;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(require 'use-package)
(defvar magit)
(use-package magit
  :ensure t
  :bind (
         ("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)
         )
  :config
  (progn
    ;; TODO: Temporary solution for handling Magit buffers until
    ;; I can figure out a better way to make them work with evil
    (define-key magit-status-mode-map (kbd "C-g") 'kill-buffer-and-window)
    (custom-set-faces
     ;; Diff
     `(magit-diff-added ((t (:inherit diff-added))))
     `(magit-diff-added-highlight ((t (:inherit diff-added))))
     `(magit-diff-removed ((t (:inherit diff-removed))))
     `(magit-diff-removed-highlight ((t (:inherit diff-removed))))
     ;;
     `(magit-diff-file-heading ((t (:inherit diff-removed))))
     `(magit-diff-removed-highlight ((t (:inherit diff-removed))))
     )
    )
  )

(provide 'robenkleene-magit)
;;; robenkleene-magit.el ends here
