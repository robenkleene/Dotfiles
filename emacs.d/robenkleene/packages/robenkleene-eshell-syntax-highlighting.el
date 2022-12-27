;;; robenkleene-eshell-syntax-highlighting.el --- robenkleene-eshell-syntax-highlighting
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

(provide 'robenkleene-eshell-syntax-highlighting)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eshell-syntax-highlighting.el ends here
