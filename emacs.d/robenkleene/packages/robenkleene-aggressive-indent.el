;;; robenkleene-aggressive-indent.el --- robenkleene-aggressive-indent
;;; Commentary:
;;; Code:

(use-package aggressive-indent
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  :diminish
  )

(provide 'robenkleene-aggressive-indent)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-aggressive-indent.el ends here
