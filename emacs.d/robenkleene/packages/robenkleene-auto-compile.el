;;; robenkleene-auto-compile.el --- robenkleene-auto-compile
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package auto-compile
  :init
  (setq load-prefer-newer t)
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode)
  )

(provide 'robenkleene-auto-compile)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-auto-compile.el ends here
