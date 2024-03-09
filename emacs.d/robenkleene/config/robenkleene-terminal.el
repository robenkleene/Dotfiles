;;; robenkleene-terminal.el --- robenkleene-terminal
;;; Commentary:
;;; Code:

;; This adds a lot of latency, can I get away without it?
;; Only enable if macOS clipboard commands or `tmux' pasteboard are available
(progn
  ;; Need to store the last paste because the function should only return a value
  ;; if it's different than the last paste
  (setq rk/last-paste nil)
  (defun rk/safepaste (text &optional push)
    (setenv "INSIDE_EMACS" "1")
    (let (
          (process-connection-type nil)
          )
      (let ((proc (start-process "INSIDE_EMACS=1 safecopy" "*Messages*" "~/.bin/safecopy")))
        (unless (string))
        (process-send-string proc text)
        (process-send-eof proc)))
    (setq rk/last-paste text)
    )

  (defun rk/safecopy ()
    (let ((copied-text (shell-command-to-string "INSIDE_EMACS=1 ~/.bin/safepaste")))
      (unless (string= copied-text rk/last-paste)
        copied-text)))

  (setq interprogram-cut-function 'rk/safepaste)
  (setq interprogram-paste-function 'rk/safecopy)
  )

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

(define-key key-translation-map  (kbd "ESC <up>") (kbd "M-p"))
(define-key key-translation-map  (kbd "ESC <down>") (kbd "M-n"))
;; (define-key key-translation-map  (kbd "ESC <up>") (kbd "<M-up>"))
;; (define-key key-translation-map  (kbd "ESC <down>") (kbd "<M-down>"))
(define-key key-translation-map  (kbd "ESC <left>") (kbd "<M-left>"))
(define-key key-translation-map  (kbd "ESC <right>") (kbd "<M-right>"))
(define-key key-translation-map (kbd "<prior>") (kbd "<C-up>"))
(define-key key-translation-map (kbd "<next>") (kbd "<C-down>"))

(unless (string-equal system-type "darwin")
  (setq browse-url-browser-function 'eww-browse-url))

;; By default, there's a bunch of `-' at the end of the modeline, remove these
(setq-default mode-line-format (remove 'mode-line-end-spaces mode-line-format))

;; Use nicer symbol for the border on terminal that doesn't have space between `|'
(defun rk/change-window-divider ()
  (let ((display-table (or buffer-display-table standard-display-table)))
    (set-display-table-slot display-table 5 ?│)
    (set-window-display-table (selected-window) display-table)))
(add-hook 'window-configuration-change-hook 'rk/change-window-divider)

(provide 'robenkleene-terminal)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-terminal.el ends here
