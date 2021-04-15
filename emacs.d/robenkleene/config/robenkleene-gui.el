;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

;; Set path
(let ((paths-to-prepend
       (list
        "/usr/local/bin"
        (expand-file-name "~/.bin")
        (expand-file-name "~/.fzf/bin")
        (expand-file-name "~/.gem/ruby/2.5.3/bin")
        (expand-file-name "~/.nvm/versions/node/v11.4.0/bin")
        (expand-file-name "~/.rubies/ruby-2.5.3/bin")
        (expand-file-name "~/.rubies/ruby-2.5.3/lib/ruby/gems/2.5.0/bin")
        (expand-file-name "~/Library/Python/3.7/bin")
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

(setenv "PAGER" "cat")

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
;; (set-face-background 'default "#2A2A2F")
;; (set-face-background 'fringe "#2A2A2F")
;; (set-face-background 'default "#241B31")
;; (set-face-background 'fringe "#241B31")

;; Nice purple
;; (set-face-background 'default "#392248")
;; (set-face-background 'fringe "#392248")
;; Slightly darker
;; (set-face-background 'default "#3C1E49")
;; (set-face-background 'fringe "#3C1E49")
;; Darker still
(set-face-background 'default "#3A1D46")
(set-face-background 'fringe "#3A1D46")

;; Darker purple
;; (set-face-background 'default "#301B42")
;; (set-face-background 'fringe "#301B42")

;; Nova purple
;; (set-face-background 'default "#221932")
;; (set-face-background 'fringe "#221932")

;; Nova inspired purple
;; (set-face-background 'default "#291B3B")
;; (set-face-background 'fringe "#291B3B")

;; Word spacing isn't great with Fira Code
(set-face-attribute 'default nil :font "Fira Code-12:Retina")
;; (setq-default line-spacing 0.2)
;; (set-face-attribute 'default nil :font "Menlo-12")
;; Doesn't support italics
;; (set-face-attribute 'default nil :font "Inconsolata-14")
;; Supports italics
;; (set-face-attribute 'default nil :font "SF Mono-12")
;; (set-face-attribute 'default nil :font "Hack-12")
(setq-default line-spacing 0.2)

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


(setq-default initial-frame-alist
              '(
                (width . 80)
                (height . 48)
                ))
(setq-default default-frame-alist
              '(
                (width . 80)
                (height . 48)
                ))
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
(add-to-list 'initial-frame-alist
             '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(cursor-color . "#4BC840"))

;; Transparency
;; For testing the current window
;; (set-frame-parameter (selected-frame) 'alpha '(97 97))
;; The actual setting
(add-to-list 'default-frame-alist '(alpha 98 98))

;; Improve compatibility of macOS dark mode
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
;; Open files in new frames by default
;; (setq ns-pop-up-frames nil)
(setq ns-pop-up-frames t)

;; Never use GUI dialog boxes
(setq use-dialog-box nil)

;; Note this doesn't work in Terminal Emacs
;; Disabled because this makes hitting escape close splits.
;; (global-set-key [escape] 'keyboard-escape-quit)
;; This only works for isearch
;; (define-key minibuffer-local-map (kbd "ESC") 'keyboard-escape-quit)
;; This one works
(define-key key-translation-map (kbd "ESC") (kbd "C-g")) ;

(provide 'robenkleene-gui)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-gui.el ends here
