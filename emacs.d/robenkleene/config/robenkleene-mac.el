;;; robenkleene-mac.el --- robenkleene-mac
;;; Commentary:
;;; Code:

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;; Open files in new frames by default
(setq ns-pop-up-frames t)

;; Use thinner fonts (I'm not convinced this does anything)
(setq ns-use-thin-smoothing t)

;; Dark transparent menu bar
;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(defvar rk/mac-bindings-minor-mode-map (make-keymap))

(global-set-key (kbd "s-v")
                (lambda ()
                  (interactive)
                  ;; (insert (shell-command-to-string "~/.bin/safepaste")))
                  (insert (shell-command-to-string "pbpaste"))
                  )
                )

(global-unset-key (kbd "s-q"))
(define-key rk/mac-bindings-minor-mode-map
            (kbd "s-q")
            'save-buffers-kill-terminal)

;; Text Editing
(define-key rk/mac-bindings-minor-mode-map
            (kbd "<s-up>") 'beginning-of-buffer)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "<s-down>") 'end-of-buffer)

;; Window management
(define-key rk/mac-bindings-minor-mode-map (kbd "s-`") 'other-frame)
(define-key rk/mac-bindings-minor-mode-map (kbd "s-w") 'delete-frame)
(define-key rk/mac-bindings-minor-mode-map
            (kbd "s-n")
            'make-frame)
(define-key rk/mac-bindings-minor-mode-map
            (kbd "C-s-f")
            'toggle-frame-fullscreen)
(define-key rk/mac-bindings-minor-mode-map
            (kbd "<C-s-268632070>")
            'toggle-frame-fullscreen)

;; Hide Emacs if we try to delete the last frame
;; This is actually a bit strange because hiding an app makes it lose focus, so
;; when another app is brought into focus it might have strange side effects
;; (defun rk/delete-frame-or-hide-emacs ()
;;   "Delete the selected frame.  If the last one, kill Emacs."
;;   (interactive)
;;   (condition-case nil (delete-frame) (error (ns-hide-emacs 1))))
;; (global-set-key [remap delete-frame] 'rk/delete-frame-or-hide-emacs)


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
