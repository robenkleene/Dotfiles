;;; robenkleene-eglot.el --- robenkleene-eglot
;;; Commentary:
;;; Code:

(use-package eglot
  :hook (((c-mode
           c++-mode
           rust-mode
           ruby-mode
           sh-mode) . eglot-ensure)
         )
  :bind (:map eglot-mode-map
              ("C-c g r" . xref-find-references)
              ("C-c g y" . eglot-find-typeDefinition)
              ("C-c g i" . eglot-find-implementation)
              ;; Also bound to `M-.' by default
              ("C-c g d" . xref-find-definitions)
              ;; ("C-c g d" . eglot-find-declaration)
              ;; ("C-c f D" . xref-find-definitions-other-window)
              ;; ("C-c f D" . xref-find-definitions-other-window)
              ("C-c =" . eglot-format-buffer)
              ("C-c c" . eglot-completion-at-point)
              ("C-c r" . eglot-rename)
              ("C-c a" . eglot-code-actions))
  :config
  ;; Turn off automatic syntax checking
  ;; (setq eglot-send-changes-idle-time (* 60 60))

  ;; Languages
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-to-list 'eglot-server-programs '(rust-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(shell-script-mode "bash-language-server"))
  (add-to-list 'eglot-server-programs '(ruby-mode "solargraph" "socket" "--port" :autoport))
  ;; `settings.json'
  ;; (setq-default eglot-workspace-configuration
  ;;               '((:rust-analyzer
  ;;                  :linkedProjects [""]
  ;;                  )))

  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              ;; Disable clicking flymake highlighted text
              ;; (put 'eglot-note 'flymake-overlay-control nil)
              ;; (put 'eglot-warning 'flymake-overlay-control nil)
              ;; (put 'eglot-error 'flymake-overlay-control nil)
              ;; Tweak minibuffer documentation
              ;; Disable minibuffer docs
              ;; (eldoc-mode -1)
              ;; This is supposed to make `Eldoc' and `flymake' messages
              ;; co-exist in the minibuffer, not sure it's working though
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
