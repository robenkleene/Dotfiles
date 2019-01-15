;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark t)
;; (set-face-background 'default "#232323")
;; `#1A1A1A' exactly matches the bars that the `railwaycat/homebrew-emacsmacport' adds
(set-face-background 'default "#1A1A1A")

;; Save window state
(desktop-save-mode 1)

(add-to-list 'default-frame-alist '(cursor-color . "#4BC840"))

(provide 'robenkleene-gui)
;;; robenkleene-gui.el ends here
