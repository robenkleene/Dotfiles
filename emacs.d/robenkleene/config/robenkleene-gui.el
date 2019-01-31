;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark t)
;; (set-face-background 'default "#232323")
;; `#1A1A1A' exactly matches the bars that the `railwaycat/homebrew-emacsmacport' adds
;; (set-face-background 'default "#1A1A1A")
(set-face-background 'default "#212121")
(set-face-background 'fringe "#212121")

(set-face-attribute 'default nil :font "Fira Code-12:Retina")

;; Save window state
(desktop-save-mode 1)
(setq desktop-restore-frames t)

;; Slow-down mouse scrolling
(setq mouse-wheel-scroll-amount '(0.01))
;; Don't change scrolling speed when scrolling fast
;; (setq mouse-wheel-progressive-speed nil)

(add-to-list 'default-frame-alist '(cursor-color . "#4BC840"))

(provide 'robenkleene-gui)
;;; robenkleene-gui.el ends here
