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
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  )

(provide 'robenkleene-yasnippet)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-yasnippet.el ends here
