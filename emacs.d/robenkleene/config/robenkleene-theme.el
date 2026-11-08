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

;; Dim inactive windows, like `NormalNC' in Vim. Emacs has no per-window faces,
;; so this remaps the `default' face per buffer with `face-remap-add-relative',
;; which means a buffer shown in the selected window is also undimmed in any
;; other window showing it
(defvar-local rk/dim-inactive-cookie nil
  "Cookie from `face-remap-add-relative' for dimming this buffer.")

(defun rk/dim-inactive-face ()
  "Return the `default' face attributes for inactive windows."
  ;; `background-mode' is `light' or `dark', and is updated by `load-theme'
  (if (eq (frame-parameter nil 'background-mode) 'light)
      '(:foreground "#444444" :background "#eeeeee")
    '(:foreground "#bcbcbc" :background "#262626")))

(defun rk/dim-inactive-windows (&rest _)
  "Dim buffers that aren't shown in the selected window."
  ;; `minibuffer-selected-window' keeps the window that was selected before
  ;; entering the minibuffer from being dimmed
  (let ((active (window-buffer (or (minibuffer-selected-window)
                                   (selected-window))))
        (face (rk/dim-inactive-face)))
    (walk-windows
     (lambda (window)
       (with-current-buffer (window-buffer window)
         (when rk/dim-inactive-cookie
           (face-remap-remove-relative rk/dim-inactive-cookie)
           (setq rk/dim-inactive-cookie nil))
         (unless (eq (current-buffer) active)
           (setq rk/dim-inactive-cookie
                 (face-remap-add-relative 'default face)))))
     'no-minibuffer 'visible)))

(add-hook 'window-selection-change-functions #'rk/dim-inactive-windows)
(add-hook 'window-buffer-change-functions #'rk/dim-inactive-windows)
;; `enable-theme-functions' switches the dim colors when the theme changes
;; between light and dark
(add-hook 'enable-theme-functions #'rk/dim-inactive-windows)

(provide 'robenkleene-theme)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-theme.el ends here
