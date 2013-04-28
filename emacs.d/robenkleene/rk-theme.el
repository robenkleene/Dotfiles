(provide 'rk-theme)

;; Look & Feel

;; Disable Toolbar
(if window-system
    (tool-bar-mode 0))
;; Window Positioning
(if window-system
    (add-to-list 'default-frame-alist '(top . 0))) ;; Re-positions window to the top fo the screen after loading, might become unnecessary if the emacs load sequence gets cleaned up
(scroll-bar-mode -1) ;; Disable scroolbars, use percentage

;; Theme
(load-theme 'wombat)
(set-cursor-color "#E57969")
(global-hl-line-mode t) ;; Highlight current line
;; (global-linum-mode 1) ;; Line numbers
;; Offset the number by two spaces to work around some weird fringe glitch
;; (setq linum-format "  %d ")
;; Cursor, Selection & Current Line
(set-face-attribute 'highlight nil :foreground 'unspecified :underline 'unspecified :background "#2F2F2F")
(set-face-attribute 'region nil :foreground "#ADD8E6" :background "#555555")
