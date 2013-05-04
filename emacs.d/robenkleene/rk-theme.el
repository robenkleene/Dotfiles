(provide 'rk-theme)

;; Look & Feel

;; Frames
(when window-system
  (scroll-bar-mode -1)
  (tool-bar-mode 0)
  (add-to-list 'default-frame-alist '(top . 0))
  (add-to-list 'default-frame-alist '(height . 60))
  )

;; Theme
(load-theme 'wombat)
(custom-theme-set-faces
 'wombat
 '(default ((t (:background "#191919")))))

;; Misc
(set-cursor-color "#E57969")
(global-hl-line-mode t) ;; Highlight current line
;; (global-linum-mode 1) ;; Line numbers
;; Offset the number by two spaces to work around some weird fringe glitch
;; (setq linum-format "  %d ")
;; Cursor, Selection & Current Line
(set-face-attribute 'highlight nil :foreground 'unspecified :underline 'unspecified :background "#2F2F2F")
(set-face-attribute 'region nil :foreground "#ADD8E6" :background "#555555")
