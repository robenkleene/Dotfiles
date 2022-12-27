;;; robenkleene-rainbow-mode.el --- robenkleene-rainbow-mode
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package rainbow-mode
  ;; :commands rainbow-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode)
  (add-hook 'text-mode-hook #'rainbow-mode)
  )

(provide 'robenkleene-rainbow-mode)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-rainbow-mode.el ends here
