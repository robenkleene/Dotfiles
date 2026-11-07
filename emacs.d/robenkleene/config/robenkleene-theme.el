;;; robenkleene-theme.el --- robenkleene-theme -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package ef-themes
  :config
  )

(use-package doric-themes
  :config
  )

;; Custom Background Color
(if window-system
    (progn
      ;; Override `bg-main' in the palette rather than only the `default'
      ;; face, so faces that set their own background from `bg-main' (e.g.,
      ;; `term') also use the custom color.
      ;; Xcode Black
      (setq modus-vivendi-palette-overrides '((bg-main "#292A30")))
      ;; Kleene Purple
      ;; (setq modus-vivendi-palette-overrides '((bg-main "#211930")))
      ;; BBEdit Black
      ;; (setq modus-vivendi-palette-overrides '((bg-main "#141414")))
      ;; (load-theme 'modus-operandi :no-confirm-loading)
      (load-theme 'modus-vivendi :no-confirm-loading)
      )
  (progn
    (load-theme 'modus-vivendi :no-confirm-loading)
    ;; Remove the background in Terminal
    (set-face-background 'default "unspecified-bg")
    )
  )

(provide 'robenkleene-theme)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-theme.el ends here
