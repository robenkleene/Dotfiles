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
          ;; Comments always grey
          (comment fg-dim)
          ;; Disable colorful headings
          (fg-heading-1 fg-main)
          (fg-heading-2 fg-main)
          (fg-heading-3 fg-main)
          (fg-heading-4 fg-main)
          ))

  ;; Use the `modus-operandi-tinted' background which makes the Emacs windows a
  ;; little easier to identify/
  (setq modus-operandi-palette-overrides
        '(
          (bg-main "#fbf7f0")
          ))
  ;; Don't try to match light dark themes because it's too difficult to make work over ssh
  )

(provide 'robenkleene-modus)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-modus.el ends here
