;;; robenkleene-javascript.el --- robenkleene-javascript
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package js2-mode
  :ensure t
  :defer t
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
    )
  )

(provide 'robenkleene-javascript)
;;; robenkleene-javascript.el ends here
