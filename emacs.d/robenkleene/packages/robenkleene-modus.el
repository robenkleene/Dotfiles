;;; robenkleene-modus.el --- robenkleene-modus
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package emacs
  :init
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-region '(bg-only no-extend))
  :config
  (load-theme 'modus-vivendi)
  )

(provide 'robenkleene-modus)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-modus.el ends here
