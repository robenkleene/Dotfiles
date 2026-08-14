;;; robenkleene-theme.el --- robenkleene-theme
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
      (load-theme 'modus-operandi :no-confirm-loading)
      ;; Xcode Black
      ;; (set-face-background 'default "#292A30")
      ;; Kleene Purple
      ;; (set-face-background 'default "#211930")
      ;; BBEdit Black
      ;; (set-face-background 'default "#141414")
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
