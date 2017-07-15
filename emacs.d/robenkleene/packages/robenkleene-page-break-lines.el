;;; robenkleene-page-break-lines.el --- robenkleene-page-break-lines
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package page-break-lines
  :ensure t
  :init
  (global-page-break-lines-mode)
  )

(provide 'robenkleene-page-break-lines)
;;; robenkleene-page-break-lines.el ends here
