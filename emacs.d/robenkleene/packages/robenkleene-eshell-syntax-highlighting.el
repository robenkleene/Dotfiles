;;; robenkleene-eshell-syntax-highlighting.el --- robenkleene-eshell-syntax-highlighting
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

(provide 'robenkleene-eshell-syntax-highlighting)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eshell-syntax-highlighting.el ends here
