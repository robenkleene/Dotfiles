;;; robenkleene-helm-swoop.el --- robenkleene-helm-swoop
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package helm-swoop
  :ensure t
  :bind (
         ("C-c l" . helm-swoop)
         )
  :init
  (progn
    (custom-set-faces
     `(helm-swoop-target-word-face ((t (:foreground nil :background nil :bold nil :inherit isearch))))
     `(helm-swoop-target-line-face ((t (:foreground nil :background nil :inherit hl-line))))
     )
    )
  :config
  (progn
    ;; Don't use word at cursor by default
    (setq helm-swoop-pre-input-function (lambda () nil))
    )
  )

(provide 'robenkleene-helm-swoop)
;;; robenkleene-helm-swoop.el ends here
