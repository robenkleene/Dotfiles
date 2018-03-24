;;; robenkleene-smex.el --- robenkleene-smex
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package smex
  :bind (("M-x" . smex))
  :bind (("M-RET" . smex))
  :config
  (smex-initialize))

(provide 'robenkleene-smex)
;;; robenkleene-smex.el ends here
