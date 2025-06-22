;;; robenkleene-theme.el --- robenkleene-theme
;;; Commentary:
;;; Code:

;; (if window-system
;;     (load-theme 'modus-operandi :no-confirm-loading)
;;   (load-theme 'modus-vivendi :no-confirm-loading)
;;   )

(load-theme 'modus-vivendi :no-confirm-loading)
;; Not pure black background looks a bit more natural
;; BBEdit Black
;; (set-face-background 'default "#141414")
;; Xcode Black
(set-face-background 'default "#292A30")

(provide 'robenkleene-theme)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-theme.el ends here
