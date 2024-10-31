;;; robenkleene-terminal.el --- robenkleene-terminal
;;; Commentary:
;;; Code:

;; Clipboard

(setenv "PAGER" "cat")
(setenv "GIT_PAGER" "cat")
(if (and (boundp 'server-buffer-clients) server-buffer-clients)
    (setenv "EMACSSERVER" "1")
  )

(defun rk/safecopy (text &optional push)
  ;; Do nothing if the region isn't active so that other commands like
  ;; `kill-line', don't affect the system clipboard
  (let (
        (process-connection-type nil)
        )
    (let ((proc (start-process "safecopy" nil "~/.bin/safecopy")))
      (unless (string))
      (process-send-string proc text)
      (process-send-eof proc)))
  )
(setq interprogram-cut-function 'rk/safecopy)

;; This is causing panes not to be selectable in Emacs, but disabling means
;; mouse scrolling doesn't work
;; This also breaks selecting Emacs panes with the mouse
;; This appears to be a Kitty bug
(xterm-mouse-mode 1)
(global-set-key [mouse-4] (lambda ()
                            (interactive)
                            (scroll-down 1)))
(global-set-key [mouse-5] (lambda ()
                            (interactive)
                            (scroll-up 1)))

(menu-bar-mode -1)

;; Disable cursor blinking
(setq visible-cursor nil)

;; A proper `<M-tab>' key is more important than `C-M-Tab`
(define-key key-translation-map  (kbd "C-M-i") (kbd "<M-tab>"))
(define-key key-translation-map  (kbd "ESC <up>") (kbd "<M-up>"))
(define-key key-translation-map  (kbd "ESC <down>") (kbd "<M-down>"))
(define-key key-translation-map  (kbd "ESC <left>") (kbd "<M-left>"))
(define-key key-translation-map  (kbd "ESC <right>") (kbd "<M-right>"))
(define-key key-translation-map (kbd "<prior>") (kbd "<C-up>"))
(define-key key-translation-map (kbd "<next>") (kbd "<C-down>"))

;; Just echo the URL if we in SSH (then it can be clicked to open locally in
;; the browser in most modern terminal emulators
(if (getenv "SSH_CONNECTION")
    (setq browse-url-browser-function
          (lambda (url &rest args)
            (kill-new url)
            (message "%s" url)
            )
          ))

;; By default, there's a bunch of `-' at the end of the modeline, remove these
(setq-default mode-line-format (remove 'mode-line-end-spaces mode-line-format))

;; Use nicer symbol for the border on terminal that doesn't have space between `|'
(defun rk/change-window-divider ()
  (let ((display-table (or buffer-display-table
                           standard-display-table
                           (make-display-table))))
    (set-display-table-slot display-table 5 ?│)
    (set-window-display-table (selected-window) display-table)))
(add-hook 'window-configuration-change-hook 'rk/change-window-divider)

(provide 'robenkleene-terminal)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-terminal.el ends here
