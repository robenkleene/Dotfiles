;;; robenkleene-modus.el --- robenkleene-modus
;;; Commentary:
;;; Code:

(use-package modus-themes
  :init
  ;; Remove borders around windows
  (setq modus-themes-common-palette-overrides
        '((fringe unspecified)))

  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-region '(bg-only no-extend))
  :config
  ;; (load-theme 'modus-vivendi-tinted)
  )

(provide 'robenkleene-modus)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-modus.el ends here
