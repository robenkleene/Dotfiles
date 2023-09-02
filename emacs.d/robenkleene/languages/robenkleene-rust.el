;;; robenkleene-rust.el --- robenkleene-rust
;;; Commentary:
;;; Code:

(use-package rust-mode
  :mode ("\\.rs\\'")
  :init
  ;; Make Rust `compilation-error-regexp-alist' available even if a Rust buffer
  ;; hasn't been visited first
  (with-eval-after-load "compile"
    (require 'rust-compile))
  )

(provide 'robenkleene-rust)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-rust.el ends here
