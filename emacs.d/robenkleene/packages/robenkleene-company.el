;;; robenkleene-company.el --- robenkleene-company
;;; Commentary:
;;; Code:

(require 'use-package)
(defvar company)
(use-package company
  :ensure t
  :init
  (global-company-mode)
  )

(provide 'robenkleene-company)
;;; robenkleene-company.el ends here
