;;; robenkleene-modus.el --- robenkleene-modus
;;; Commentary:
;;; Code:

(use-package modus-themes
  :init
  ;; Remove borders around windows
  ;; (setq modus-themes-common-palette-overrides
  ;;       '((fringe unspecified)))

  ;; (setq modus-themes-italic-constructs t
  ;;       modus-themes-bold-constructs t
  ;;       modus-themes-region '(bg-only no-extend))
  :config
  (setq modus-themes-common-palette-overrides
        '(
          ;; Remove the modeline border
          (border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)
          ;; Reduce the intensity a bit
          (modus-themes-preset-overrides-faint)
          ;; Make the fringe transparent, this makes windows without line
          ;; numbers look more minimal
          (fringe unspecified)
          ))
  (load-theme 'modus-vivendi-tinted)
  ;; (load-theme 'modus-vivendi)
  )

(provide 'robenkleene-modus)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-modus.el ends here
