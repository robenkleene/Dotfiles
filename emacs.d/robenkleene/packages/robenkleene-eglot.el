;;; robenkleene-eglot.el --- robenkleene-eglot
;;; Commentary:
;;; Code:

(use-package eglot
  :commands eglot
  ;; `eglot' significantly slows down opening files, try just toggling on
  ;; manually for now
  :hook (((
           swift-mode
           c++-mode
           c-mode
           css-mode
           html-mode
           js-mode
           json-mode
           lua-mode
           python-mode
           ruby-mode
           rust-mode
           sh-mode
           typescript-mode

           ;; markdown-mode
           ) . eglot-ensure)
         )
  :config
  ;; Turn off automatic syntax checking
  ;; (setq eglot-send-changes-idle-time (* 60 60))

  ;; Don't block for `eglot' to connect
  (setq eglot-sync-connect nil)

  ;; Languages
  (add-to-list 'eglot-server-programs '(css-mode "vscode-css-language-server"))
  (add-to-list 'eglot-server-programs '(html-mode "vscode-html-language-server"))
  (add-to-list 'eglot-server-programs '(js-mode "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs '(json-mode "vscode-json-language-server"))
  (add-to-list 'eglot-server-programs '(lua-mode "lua-language-server"))
  (add-to-list 'eglot-server-programs '(python-mode "pyright"))
  (add-to-list 'eglot-server-programs '(ruby-mode "solargraph" "socket" "--port" :autoport))
  (add-to-list 'eglot-server-programs '(rust-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(shell-script-mode "bash-language-server"))
  (add-to-list 'eglot-server-programs '(swift-mode "sourcekit-lsp"))
  (add-to-list 'eglot-server-programs '(typescript-mode "typescript-language-server" "--stdio"))
  ;; Special
  (if (not (assoc '(c++-mode c-mode) eglot-server-programs))
      (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
    )
  ;; (add-to-list 'eglot-server-programs '(markdown-mode "marksman"))
  ;; `settings.json'
  ;; (setq-default eglot-workspace-configuration
  ;;               '((:rust-analyzer
  ;;                  :linkedProjects [""]
  ;;                  )))

  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              ;; Disable `TAGS' file when using `eglot', this is quick way to
              ;; prevent Emacs from complaining about an existing `ctags' `TAGS'
              ;; file
              ;; (setq-local tags-file-name nil)
              ;; Disable clicking on `flymake' highlighted text to perform
              ;; actions
              (put 'eglot-note 'flymake-overlay-control nil)
              (put 'eglot-warning 'flymake-overlay-control nil)
              (put 'eglot-error 'flymake-overlay-control nil)
              ;; Tweak minibuffer documentation
              ;; Disable minibuffer docs
              ;; (eldoc-mode -1)
              ;; Only allow one lien in echo area for eldoc
              (setq eldoc-echo-area-use-multiline-p nil)
              ;; This is supposed to make `Eldoc' and `flymake' messages
              ;; co-exist in the minibuffer, not sure it's working though
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)
              ;; Don't bold the current symbol (we can just search for it to get
              ;; this functionality and it's less distracting that way)
              ;; (setq eglot-ignored-server-capabilites '(:documentHighlightProvider))

              ;; `eglot-completion-at-point' breaks all other completions,
              ;; including `yasnippet' if it's first in the
              ;; `completion-at-point-functions' list moving it to last seems to
              ;; fix it
              ;; (remove-hook 'completion-at-point-functions #'eglot-completion-at-point t)
              ;; (add-to-list 'completion-at-point-functions #'eglot-completion-at-point t)

              ))
  )

(provide 'robenkleene-eglot)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eglot.el ends here
