;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package helm
  :ensure t
  :defer t
  :config
  (setq helm-truncate-lines t)
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
