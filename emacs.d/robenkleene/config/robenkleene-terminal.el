;;; robenkleene-terminal.el --- robenkleene-terminal
;;; Commentary:
;;; Code:

;; Need to store the last paste because the function should only return a value
;; if it's different than the last paste
;; Disabled for now because we're using a single clipboard override for both GUI
;; and terminal Emacs
; (setq rk/last-copy nil)
; (defun rk/safecopy (text &optional push)
;   ;; Do nothing if the region isn't active so that other commands like
;   ;; `kill-line', don't affect the system clipboard
;   (setenv "INSIDE_EMACS" "1")
;   (let (
;         (process-connection-type nil)
;         )
;     (let ((proc (start-process "safecopy" nil "~/.bin/safecopy")))
;       (unless (string))
;       (process-send-string proc text)
;       (process-send-eof proc)))
;   (setq rk/last-copy text)
;   )
; (defun rk/safepaste ()
;   (let ((result (shell-command-to-string "INSIDE_EMACS=1 ~/.bin/safepaste")))
;     (unless (string= result rk/last-copy)
;       result)))
; (setq interprogram-cut-function 'rk/safecopy)
; (setq interprogram-paste-function 'rk/safepaste)

;; Enable mouse support
(xterm-mouse-mode 1)

;; Remove menu bar
(menu-bar-mode -1)

;; A proper `<M-tab>' key is more important than `C-M-Tab`
(define-key key-translation-map  (kbd "C-M-i") (kbd "<M-tab>"))
(define-key key-translation-map  (kbd "ESC <up>") (kbd "<M-up>"))
(define-key key-translation-map  (kbd "ESC <down>") (kbd "<M-down>"))
(define-key key-translation-map  (kbd "ESC <left>") (kbd "<M-left>"))
(define-key key-translation-map  (kbd "ESC <right>") (kbd "<M-right>"))
(define-key key-translation-map (kbd "<prior>") (kbd "<C-up>"))
(define-key key-translation-map (kbd "<next>") (kbd "<C-down>"))

;; This seems to be working by default now
;; (global-set-key (kbd "<wheel-down>") (lambda ()
;;                                        (interactive) (scroll-up-line 5)))
;; (global-set-key (kbd "<wheel-up>") (lambda ()
;;                                      (interactive) (scroll-down-line 5)))

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
