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
