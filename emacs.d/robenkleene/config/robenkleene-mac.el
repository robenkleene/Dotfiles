;;; robenkleene-mac.el --- robenkleene-mac
;;; Commentary:
;;; Code:

;; This adds a lot of latency, can I get away without it?
;; Fix cut & paste
;; Need to store the last paste because the function should only return a value
;; if it's different than the last paste
;; (setq rk/last-paste nil)
;; (defun rk/copy-from-osx ()
;;   (let ((copied-text (shell-command-to-string "pbpaste")))
;;     (unless (string= copied-text rk/last-paste)
;;       copied-text)))
;; (setq interprogram-paste-function 'rk/copy-from-osx)

;; (defun rk/paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc)))
;;   (setq rk/last-paste text)
;;   )
;; (setq interprogram-cut-function 'rk/paste-to-osx)

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;; Hide the window title completely, which looks cool
;; This works by moving the frame size information to the second line which
;; isn't visible
(setq-default frame-title-format '("\n"))
(setq ns-use-proxy-icon nil)

(defvar rk/mac-bindings-minor-mode-map (make-keymap))

;; Selection
(define-key rk/mac-bindings-minor-mode-map
            (kbd "s-a")
            'mark-whole-buffer)

(global-unset-key (kbd "s-q"))
(define-key rk/mac-bindings-minor-mode-map
	    (kbd "s-q")
	    'save-buffers-kill-terminal)

;; Window management
(define-key rk/mac-bindings-minor-mode-map (kbd "s-`") 'other-frame)
(define-key rk/mac-bindings-minor-mode-map (kbd "s-w") 'delete-frame)
(define-key rk/mac-bindings-minor-mode-map
            (kbd "s-n")
            'make-frame-with-current-frame)
(define-key rk/mac-bindings-minor-mode-map
	    (kbd "C-s-f")
	    'toggle-frame-fullscreen)
(define-key rk/mac-bindings-minor-mode-map
            (kbd "<C-s-268632070>")
            'toggle-frame-fullscreen)

;; Editing
;; Undo
(define-key rk/mac-bindings-minor-mode-map
            (kbd "s-z")
            'undo-only)
(define-key rk/mac-bindings-minor-mode-map
	    (kbd "s-Z")
	    'undo-redo)
(define-key rk/mac-bindings-minor-mode-map
	    (kbd "s-c")
	    'kill-ring-save)

;; Movement
(define-key rk/mac-bindings-minor-mode-map
            (kbd "<s-up>") 'beginning-of-buffer)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "<s-down>") 'end-of-buffer)
(define-key rk/mac-bindings-minor-mode-map
	    (kbd "<s-left>") 'beginning-of-visual-line)
(define-key rk/mac-bindings-minor-mode-map
	    (kbd "<s-right>") 'end-of-visual-line)


;; Mode
(define-minor-mode rk/mac-bindings-minor-mode
  "Mac bindings."
  :init-value t
  :lighter nil
  :keymap 'rk/mac-bindings-minor-mode-map)
(rk/mac-bindings-minor-mode 1)

(provide 'robenkleene-mac)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-mac.el ends here
