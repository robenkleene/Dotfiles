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
  )

(provide 'robenkleene-magit)
;;; robenkleene-magit.el ends here
