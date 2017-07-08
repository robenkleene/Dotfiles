;;; robenkleene-evil-modes.el --- robenkleene-evil-modes
;;; Commentary:
;;; Code:

;; Disable insert mode key map
(setcdr evil-insert-state-map nil)
;; Re-enable `esc'
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;; Disable Evil's integrations
(defun evil-make-overriding-map (keymap &optional state copy)
  "No-op."
  )
(defmacro evil-add-hjkl-bindings (keymap &optional state &rest bindings)
  "No-op."
  )

;; Don't default any buffers to insert mode
(setq evil-emacs-state-modes ())
(setq evil-insert-state-modes ())
;; Add help mode so `q' can quit the help buffer
(setq evil-motion-state-modes '(help-mode))



(provide 'robenkleene-evil-modes)
;;; robenkleene-evil-modes.el ends here
