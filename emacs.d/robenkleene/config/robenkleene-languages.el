;;; robenkleene-languages.el --- robenkleene-languages
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("zshenv$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.pde\\'" . java-mode))

(add-to-list 'magic-mode-alist
             '("^\\(?:diff --git\\|changeset: \\|commit \\)" . diff-mode))

(provide 'robenkleene-languages)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-languages.el ends here
