;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package helm
  :ensure t
  :config
  (progn
    (setq helm-truncate-lines t)
    )
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
