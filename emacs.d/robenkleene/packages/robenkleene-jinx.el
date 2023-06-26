;;; robenkleene-jinx.el --- robenkleene-jinx
;;; Commentary:
;;; Code:

(use-package jinx
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))

(provide 'robenkleene-jinx)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-jinx.el ends here
