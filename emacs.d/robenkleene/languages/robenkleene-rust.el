;;; robenkleene-rust.el --- robenkleene-rust
;;; Commentary:
;;; Code:

(use-package rustic
  :config
  (setq
   rustic-lsp-client 'eglot
   rustic-format-on-save nil
   )
  )

(provide 'robenkleene-rust)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-rust.el ends here
