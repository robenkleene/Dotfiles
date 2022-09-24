;;; robenkleene-eglot.el --- robenkleene-eglot
;;; Commentary:
;;; Code:

(use-package eglot
  :defines (eglot-mode-map eglot-server-programs)
  :hook (((c-mode c++-mode) . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c r" . eglot-rename)
              ("C-c f r" . xref-find-references)
              ("C-c f d" . eglot-find-declaration)
              ("C-c f D" . xref-find-definitions-other-window)
              ("C-c f t" . eglot-find-typeDefinition)
              ("C-c f i" . eglot-find-implementation)
              ("C-c =" . eglot-format-buffer)
              ("C-c c" . eglot-completion-at-point)
              ("C-c r" . eglot-rename)
              ("C-c a" . eglot-code-actions))
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  )

(provide 'robenkleene-eglot)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eglot.el ends here
