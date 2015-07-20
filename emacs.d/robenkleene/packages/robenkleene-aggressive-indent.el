;;; robenkleene-aggressive-indent.el --- robenkleene-smartparens
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package aggressive-indent
  :ensure t
  :init
  (progn
    (global-aggressive-indent-mode 1)
    (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
    (add-to-list 'aggressive-indent-excluded-modes 'swift-mode)
    )
  )

(provide 'robenkleene-aggressive-indent)
;;; robenkleene-aggressive-indent.el ends here
