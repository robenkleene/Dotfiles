;;; robenkleene-eglot.el --- robenkleene-eglot
;;; Commentary:
;;; Code:

(use-package eglot
  :hook (((c-mode c++-mode rust-mode) . eglot-ensure))
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

  ;; Turn off automatic syntax checking
  ;; (setq eglot-send-changes-idle-time (* 60 60))

  ;; Languages
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-to-list 'eglot-server-programs '((rust-mode) "rust-analyzer"))
  ;; `settings.json'
  ;; (setq-default eglot-workspace-configuration
  ;;               '((:rust-analyzer
  ;;                  :linkedProjects [""]
  ;;                  )))

  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              ;; Disable clicking flymake highlighted text
              (put 'eglot-note 'flymake-overlay-control nil)
              (put 'eglot-warning 'flymake-overlay-control nil)
              (put 'eglot-error 'flymake-overlay-control nil)
              ;; Tweak minibuffer documentation
              ;; Disable minibuffer docs
              ;; (eldoc-mode -1)
              ;; Show all diagnostic information in the minibuffer
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)
              ))
  )

(provide 'robenkleene-eglot)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eglot.el ends here
