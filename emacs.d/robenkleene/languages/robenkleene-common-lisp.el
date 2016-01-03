;;; robenkleene-common-lisp.el --- robenkleene-common-lisp
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package slime
  :ensure t
  :defer t
  ;; :config
  ;; (progn
  ;;   (setq inferior-lisp-program "/usr/bin/sbcl")
  ;;   (slime-setup))
  )

(provide 'robenkleene-common-lisp)
;;; robenkleene-common-lisp.el ends here
