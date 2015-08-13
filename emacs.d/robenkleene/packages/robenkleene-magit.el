;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:

(require 'use-package)
;; A bit of a hack to load this here, but many things fail with undefined `magit-blame-mode' without this
(require 'magit-blame)

(use-package magit
  :ensure t
  :bind (
         ("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)
         )
  )

(provide 'robenkleene-magit)
;;; robenkleene-magit.el ends here
