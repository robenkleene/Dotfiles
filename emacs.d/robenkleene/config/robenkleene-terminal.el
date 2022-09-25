;;; robenkleene-terminal.el --- robenkleene-terminal
;;; Commentary:
;;; Code:

;; Need to store the last paste because the function should only return a value
;; if it's different than the last paste
(setq robenkleene/last-paste nil)
(defun robenkleene/safepaste (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "safecopy" "*Messages*" "safecopy")))
      (unless (string))
      (process-send-string proc text)
      (process-send-eof proc)))
  (setq robenkleene/last-paste text)
  )
(setq interprogram-cut-function 'robenkleene/safepaste)

(defun robenkleene/safecopy ()
  (let ((copied-text (shell-command-to-string "safepaste")))
    (unless (string= copied-text robenkleene/last-paste)
      copied-text)))
(setq interprogram-paste-function 'robenkleene/safecopy)

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark t)

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

;; (define-key key-translation-map  (kbd "ESC <up>") (kbd "<M-up>"))
;; (define-key key-translation-map  (kbd "ESC <down>") (kbd "<M-down>"))
;; These should only be assigned for terminal modes
;; (define-key key-translation-map  (kbd "ESC <up>") (kbd "M-p"))
;; (define-key key-translation-map  (kbd "ESC <down>") (kbd "M-n"))
(define-key key-translation-map  (kbd "ESC <up>") (kbd "<M-up>"))
(define-key key-translation-map  (kbd "ESC <down>") (kbd "<M-down>"))
(define-key key-translation-map  (kbd "ESC <left>") (kbd "<M-left>"))
(define-key key-translation-map  (kbd "ESC <right>") (kbd "<M-right>"))
(define-key key-translation-map (kbd "<prior>") (kbd "<C-up>"))
(define-key key-translation-map (kbd "<next>") (kbd "<C-down>"))

;; Using `M-[' for `backward-block' isn't possible because `M-[' is the sequence
;; for escape so it messes with many bindings
(define-key robenkleene/bindings-minor-mode-map (kbd "M-}")
  'robenkleene/forward-block)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-{")
  'robenkleene/backward-block)

(provide 'robenkleene-terminal)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-terminal.el ends here
