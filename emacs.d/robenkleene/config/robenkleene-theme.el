;;; robenkleene-theme.el --- robenkleene-theme
;;; Commentary:
;;; Code:

(use-package ef-themes
  :config
  ;; (load-theme 'ef-owl :no-confirm-loading)
  )

;; (if window-system
;;     (load-theme 'modus-operandi :no-confirm-loading)
;;   (load-theme 'modus-vivendi :no-confirm-loading)
;;   )

(load-theme 'modus-vivendi :no-confirm-loading)

;; Custom Background Color
;; `git diff' in `term-mode' from `eshell-visual' expects a pure black background
;; (if window-system
;;     ;; Not pure black background looks a bit more natural
;;     ;; BBEdit Black
;;     ;; (set-face-background 'default "#141414")
;;     ;; Xcode Black
;;     (set-face-background 'default "#292A30")
;;   ;; Kleene Purple
;;   ;; (set-face-background 'default "#211930")
;;   )

(provide 'robenkleene-theme)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-theme.el ends here
