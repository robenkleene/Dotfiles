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
  "Add bindings to KEYMAP in STATE.
Add additional BINDINGS if specified."
  (declare (indent defun))
  `(evil-define-key ,state ,keymap
     "h" (lookup-key evil-motion-state-map "h")
     "j" (lookup-key evil-motion-state-map "j")
     "k" (lookup-key evil-motion-state-map "k")
     "l" (lookup-key evil-motion-state-map "l")
     ":" (lookup-key evil-motion-state-map ":")
     "v" (lookup-key evil-motion-state-map "v")
     "V" (lookup-key evil-motion-state-map "V")
     "e" (lookup-key evil-motion-state-map "e")
     "E" (lookup-key evil-motion-state-map "E")
     "w" (lookup-key evil-motion-state-map "w")
     "W" (lookup-key evil-motion-state-map "W")
     "b" (lookup-key evil-motion-state-map "b")
     "B" (lookup-key evil-motion-state-map "B")
     "y" (lookup-key evil-motion-state-map "y")
     "Y" (lookup-key evil-motion-state-map "Y")
     "c" (lookup-key evil-motion-state-map "c")
     "C" (lookup-key evil-motion-state-map "C")
     "g" (lookup-key evil-motion-state-map "g")
     "G" (lookup-key evil-motion-state-map "G")
     "a" (lookup-key evil-motion-state-map "a")
     "i" (lookup-key evil-motion-state-map "i")
     "n" (lookup-key evil-motion-state-map "n")
     "N" (lookup-key evil-motion-state-map "N")
     "\M-p" (lookup-key evil-motion-state-map "\M-p")
     "\M-n" (lookup-key evil-motion-state-map "\M-n")
     " " robenkleene/leader-map
     "-" (lookup-key evil-motion-state-map "-")
     "\C-o" (lookup-key evil-motion-state-map "\C-o")
     ;; Using this prevents tab from being usable since it's the same key
     ;; "\C-i" (lookup-key evil-motion-state-map "\C-i")
     "\C-w" (lookup-key evil-motion-state-map "\C-w")
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
