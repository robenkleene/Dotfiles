;;; robenkleene-yasnippet.el --- yasnippet
;;; Commentary:
;;; Code:

(use-package yasnippet
  :diminish (yas-minor-mode)
  :bind (:map snippet-mode-map
              ("C-c C-k" . yas-abort-snippet))
  :init
  (yas-global-mode 1)
  :config
  ;; This is the default
  ;; (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  ;; Allow snippet `key' to be expanded with `hippie-expand'
  ;; This isn't working for some reason
  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  )

(provide 'robenkleene-yasnippet)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-yasnippet.el ends here
