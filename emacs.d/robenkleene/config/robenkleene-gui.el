;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

;; Set path
(let ((paths-to-prepend
       (list
        "/usr/local/bin"
        (expand-file-name "~/.bin")
        (expand-file-name "~/.nvm/versions/node/v0.12.2/bin/")
        )
       ))
  (setenv "PATH" (mapconcat
                  'identity
                  (append paths-to-prepend
                          (list (getenv "PATH")))
                  ":"))
  (dolist (path-to-prepend paths-to-prepend)
    (add-to-list 'exec-path path-to-prepend))
  )

;; Start the emacs server if it isn't already running and we're running in
;; window mode
;; (require 'server)
;; (if (display-graphic-p (selected-frame))
;;     (if (and (fboundp 'server-running-p)
;;              (not (server-running-p)))
;;         (server-start)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark t)
;; (set-face-background 'default "#232323")
;; `#1A1A1A' exactly matches the bars that the
;; `railwaycat/homebrew-emacsmacport' adds
;; (set-face-background 'default "#1A1A1A")
(set-face-background 'default "#212121")
(set-face-background 'fringe "#212121")

(set-face-attribute 'default nil :font "Fira Code-12:Retina")

;; Cursor
(setq-default cursor-type 'bar)

;; Save window state
(desktop-save-mode 1)

;; Slow-down mouse scrolling
(setq mouse-wheel-scroll-amount '(0.001))
;; Don't change scrolling speed when scrolling fast
;; (setq mouse-wheel-progressive-speed nil)

;; Disable mouse highlighting
(setq mouse-highlight nil)

(add-to-list 'default-frame-alist '(cursor-color . "#4BC840"))

;; Improve compatibility of macOS dark mode
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(provide 'robenkleene-gui)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-gui.el ends here
