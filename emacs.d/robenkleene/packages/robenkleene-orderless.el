;;; robenkleene-orderless.el --- robenkleene-orderless
;;; Commentary:
;;; Code:

;; `orderless' allows quickly opening files, e.g., `C-x C-r' to open recent
;; files, and then just type part of the filename, case insensitive. Without
;; `orderless', `*' needs to be the first character (to handle the file path),
;; and file paths are case sensitive.
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
