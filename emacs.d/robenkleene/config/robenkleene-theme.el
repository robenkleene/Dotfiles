;;; robenkleene-theme.el --- robenkleene-theme -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package ef-themes
  :config
  )

(use-package doric-themes
  :config
  )

;; Terminal colors for Eshell output (which uses the `ansi-color' faces) and
;; visual commands (which use the `term-color' faces)
(defvar rk/term-palette-overrides
  '(
    (fg-term-black "#000000")
    (bg-term-black "#000000")
    (fg-term-black-bright "#878787")
    (bg-term-black-bright "#878787")
    (fg-term-red "#FF8787")
    (bg-term-red "#FF8787")
    (fg-term-red-bright "#FFAF87")
    (bg-term-red-bright "#FFAF87")
    (fg-term-green "#87FF87")
    (bg-term-green "#87FF87")
    (fg-term-green-bright "#AFFF87")
    (bg-term-green-bright "#AFFF87")
    (fg-term-yellow "#FFFF00")
    (bg-term-yellow "#FFFF00")
    (fg-term-yellow-bright "#FFFFAF")
    (bg-term-yellow-bright "#FFFFAF")
    (fg-term-blue "#5FAFFF")
    (bg-term-blue "#5FAFFF")
    (fg-term-blue-bright "#87AFFF")
    (bg-term-blue-bright "#87AFFF")
    (fg-term-magenta "#FF87FF")
    (bg-term-magenta "#FF87FF")
    (fg-term-magenta-bright "#FFAFFF")
    (bg-term-magenta-bright "#FFAFFF")
    (fg-term-cyan "#5FFFFF")
    (bg-term-cyan "#5FFFFF")
    (fg-term-cyan-bright "#AFFFFF")
    (bg-term-cyan-bright "#AFFFFF")
    (fg-term-white "#FFFFFF")
    (bg-term-white "#FFFFFF")
    (fg-term-white-bright "#D7D7D7")
    (bg-term-white-bright "#D7D7D7")
    )
  "Modus palette overrides for terminal colors.")

;; Custom Background Color
(if window-system
    (progn
      ;; Override `bg-main' in the palette rather than only the `default'
      ;; face, so faces that set their own background from `bg-main' (e.g.,
      ;; `term') also use the custom color.
      ;; Xcode Black
      ;; (setq modus-vivendi-palette-overrides
      ;;       (append '((bg-main "#292A30")) rk/term-palette-overrides))
      ;; Kleene Purple
      ;; (setq modus-vivendi-palette-overrides
      ;;       (append '((bg-main "#211930")) rk/term-palette-overrides))
      ;; BBEdit Black
      (setq modus-vivendi-palette-overrides
            (append '((bg-main "#141414")) rk/term-palette-overrides))
      ;; (load-theme 'modus-operandi :no-confirm-loading)
      (load-theme 'modus-vivendi :no-confirm-loading)
      )
  (progn
    (setq modus-vivendi-palette-overrides rk/term-palette-overrides)
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
