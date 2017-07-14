;;; robenkleene-evil-integration.el --- robenkleene-evil-integration
;;; Commentary:
;;; Code:

;; Don't default any buffers to insert mode
;; Add help mode so `q' can quit the help buffer

;; Disable `evil-integration.el'
(defun evil-make-overriding-map (keymap &optional state copy)
  "No-op."
  )
(defmacro evil-add-hjkl-bindings (keymap &optional state &rest bindings)
  "No-op."
  )

;; Create my own versions of these functions
(defvar evil-motion-state-map)
(defmacro robenkleene/evil-add-hjkl-bindings (keymap &optional state &rest bindings)
  "Add \"h\", \"j\", \"k\", \"l\" bindings to KEYMAP in STATE.
Add additional BINDINGS if specified."
  (declare (indent defun))
  `(evil-define-key ,state ,keymap
     "h" (lookup-key evil-motion-state-map "h")
     "j" (lookup-key evil-motion-state-map "j")
     "k" (lookup-key evil-motion-state-map "k")
     "l" (lookup-key evil-motion-state-map "l")
     ":" (lookup-key evil-motion-state-map ":")
     ,@bindings))

(defun robenkleene/evil-make-overriding-map (keymap &optional state copy)
  "Give KEYMAP precedence over the global keymap of STATE.
The keymap will have lower precedence than custom STATE bindings.
If STATE is nil, give it precedence over all states.
If COPY is t, create a copy of KEYMAP and give that
higher precedence. See also `evil-make-intercept-map'."
  (let ((key [override-state]))
    (if (not copy)
        (define-key keymap key (or state 'all))
      (unless (keymapp copy)
        (setq copy (assq-delete-all 'menu-bar (copy-keymap keymap))))
      (define-key copy key (or state 'all))
      (define-key keymap key copy))))

(defmacro robenkleene/evilify (package mode keymap state &rest bindings)
  "After loading a PACKAGE, Evil integration for a MODE.
And a corresponding KEYMAP for a STATE.  Add additional BINDINGS."
  `(eval-after-load ,package
     '(progn
        (defvar ,keymap)
        (robenkleene/evil-make-overriding-map ,keymap ,state)
        (robenkleene/evil-add-hjkl-bindings ,keymap ,state ,@bindings)
        )
     )
  )

(provide 'robenkleene-evil-integration)
;;; robenkleene-evil-integration.el ends here
