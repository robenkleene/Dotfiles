;;; robenkleene-javascript.el --- robenkleene-javascript
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package js2-mode
  :ensure t
  :init
  :mode "\\.js\\'"
  )

(provide 'robenkleene-javascript)
;;; robenkleene-javascript.el ends here
