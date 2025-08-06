;;; robenkleene-orderless.el --- robenkleene-orderless
;;; Commentary:
;;; Code:

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  ;; `TRAMP' hostname complete needs `basic'
  ;; `partial-completion' is good for `/u/s/l' for `/usr/share/local'
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'robenkleene-orderless)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-orderless.el ends here
