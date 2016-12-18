;;; robenkleene-smex.el --- robenkleene-smex
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package smex
  :ensure t
  :bind (("M-x" . smex))
  :config
  (smex-initialize))

(provide 'robenkleene-smex)
;;; robenkleene-smex.el ends here
