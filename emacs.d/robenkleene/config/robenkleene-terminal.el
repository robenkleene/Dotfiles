;;; robenkleene-terminal.el --- robenkleene-terminal
;;; Commentary:
;;; Code:

;; Only enable if macOS clipboard commadns or `tmux' pasteboard are available
(if (or (getenv "TMUX") (rk/system-is-mac))
    (progn
      ;; Need to store the last paste because the function should only return a value
      ;; if it's different than the last paste
      (setq rk/last-paste nil)
      (defun rk/safepaste (text &optional push)
        (let ((process-connection-type nil))
          (let ((proc (start-process "safecopy" "*Messages*" "safecopy")))
            (unless (string))
            (process-send-string proc text)
            (process-send-eof proc)))
        (setq rk/last-paste text)
        )

      (defun rk/safecopy ()
        (let ((copied-text (shell-command-to-string "safepaste")))
          (unless (string= copied-text rk/last-paste)
            copied-text)))

      (setq interprogram-cut-function 'rk/safepaste)
      (setq interprogram-paste-function 'rk/safecopy)
      )
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

;; Theoretically this would be clear in `delete-frame-functions' but for
;; `emacsclient' connections that's being called after the frame is deleted and
;; the `default-directory' is then wrong
(defadvice delete-frame
    (before rk/delete-frame-chdir activate)
  "Write to chdir and save desktop."
  (if (file-exists-p "/tmp/vim.robenkleene/chdir/chdir")
      (write-region
       (expand-file-name default-directory)
       nil
       "/tmp/vim.robenkleene/chdir/chdir"
       )
    )
  ;; Prevent prompting for existing desktop files
  ;; This isn't much use because it doesn't work nicely with `emacsclient'
  ;; (if (file-exists-p (concat desktop-dirname ".emacs.desktop"))
  ;;     (delete-file (concat desktop-dirname ".emacs.desktop"))
  ;;   )
  ;; (if (file-exists-p (concat desktop-dirname ".emacs.desktop.lock"))
  ;;     (delete-file (concat desktop-dirname ".emacs.desktop.lock"))
  ;;   )
  ;; (desktop-save-in-desktop-dir)
  )

(unless (rk/system-is-mac)
  (setq browse-url-browser-function 'eww-browse-url))

;; By default, there's a bunch of `-' at the end of the modeline, remove these
(setq-default mode-line-format (remove 'mode-line-end-spaces mode-line-format))

;; Use nicer symbol for the border on terminal that doesn't have space between `|'
(set-display-table-slot standard-display-table
                        'vertical-border 
                        (make-glyph-code ?│))

(provide 'robenkleene-terminal)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-terminal.el ends here
