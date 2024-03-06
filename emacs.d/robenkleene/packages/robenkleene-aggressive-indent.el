;;; robenkleene-aggressive-indent.el --- robenkleene-aggressive-indent
;;; Commentary:
;;; Code:

(use-package aggressive-indent
  :diminish
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  )

(provide 'robenkleene-aggressive-indent)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-aggressive-indent.el ends here
