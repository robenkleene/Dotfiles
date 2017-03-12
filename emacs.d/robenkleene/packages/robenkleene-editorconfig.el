;;; robenkleene-editorconfig.el --- robenkleene-editorconfig
;;; Commentary:
;;; Code:


(require 'use-package)
(use-package editorconfig
  :ensure t
  :config
  (add-to-list 'editorconfig-indentation-alist '(markdown-mode markdown-list-indent-width))
  (editorconfig-mode 1)
  )

(provide 'robenkleene-editorconfig)
;;; robenkleene-editorconfig.el ends here
