(rk-install-package-if-missing 'markdown-mode)

;; Need to disable the option left/right bindings

;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


(provide 'rk-markdown)
