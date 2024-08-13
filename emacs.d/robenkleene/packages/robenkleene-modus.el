;;; robenkleene-modus.el --- robenkleene-modus
;;; Commentary:
;;; Code:

(use-package modus-themes
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
          ;; Remove the line number background, which looks better when the
          ;; fringe isn't present (e.g., when editing a text file)
          (bg-line-number-inactive unspecified)
          (bg-line-number-active unspecified)
          ;; Make the current tab the same color as background
          (bg-tab-current bg-main)
          ;; Dim the highlight line, the default was making it sometimes hard to
          ;; find the cursor
          (bg-hl-line bg-inactive)
          ))
  (setq modus-vivendi-tinted-palette-overrides
        '(
          (bg-main "#211930")
          ;; (bg-main "#1A1B25")
          ))

  ;; (load-theme 'modus-vivendi-tinted)
  ;; (load-theme 'modus-vivendi)
  (load-theme 'modus-operandi)
  )

(provide 'robenkleene-modus)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-modus.el ends here
