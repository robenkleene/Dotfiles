;;; robenkleene-rust.el --- robenkleene-rust
;;; Commentary:
;;; Code:

;; (use-package rustic
;;   :config
;;   (setq
;;    rustic-lsp-client 'eglot
;;    rustic-format-on-save nil
;;    )
;;   )

(use-package rust-mode
  :ensure t
  :config
  (add-hook 'rust-mode-hook
            (lambda ()
              (setq-local robenkleene/format-function
                          'eglot-format)
              ))
  )

(provide 'robenkleene-rust)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-rust.el ends here
