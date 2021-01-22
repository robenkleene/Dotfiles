;;; robenkleene-lsp.el --- robenkleene-lsp
;;; Commentary:
;;; Code:

(use-package lsp-mode
  ;; :hook (
  ;;        (enh-ruby-mode . lsp)
  ;;        (swift-mode . lsp)
  ;;        )
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(provide 'robenkleene-lsp)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-lsp.el ends here
