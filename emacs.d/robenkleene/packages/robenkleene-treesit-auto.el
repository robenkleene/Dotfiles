;;; robenkleene-treesit-auto.el --- robenkleene-treesit-auto
;;; Commentary:
;;; Code:

(use-package treesit-auto
  :init
  (setq treesit-auto-install t)
  :config
  ;; Automatically use the `-ts-mode'
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(provide 'robenkleene-treesit-auto)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-treesit-auto.el ends here
