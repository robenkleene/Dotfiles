;;; robenkleene-evil-modes.el --- robenkleene-evil-modes
;;; Commentary:
;;; Code:

;; Disable `evil-integration.el'
(defun evil-make-overriding-map (keymap &optional state copy)
  "No-op."
  )
(defmacro evil-add-hjkl-bindings (keymap &optional state &rest bindings)
  "No-op."
  )

;; Create my own versions of these functions
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

(eval-after-load 'dired
  '(progn
     ;; use the standard Dired bindings as a base
     (defvar dired-mode-map)
     (robenkleene/evil-make-overriding-map dired-mode-map 'motion)
     (robenkleene/evil-add-hjkl-bindings dired-mode-map 'motion
                                         ;; "J" 'dired-goto-file                   ; "j"
                                         ;; "K" 'dired-do-kill-lines               ; "k"
                                         ;; "r" 'dired-do-redisplay                ; "l"
                                         ;; ;; ":d", ":v", ":s", ":e"
                                         ;; ";" (lookup-key dired-mode-map ":")
                                         )
     )
  )

(eval-after-load 'magit
  '(progn
     ;; use the standard Dired bindings as a base
     (defvar magit-status-mode-map)
     (robenkleene/evil-make-overriding-map magit-status-mode-map 'motion)
     (robenkleene/evil-add-hjkl-bindings magit-status-mode-map 'motion
                                         ;; "J" 'dired-goto-file                   ; "j"
                                         ;; "K" 'dired-do-kill-lines               ; "k"
                                         ;; "r" 'dired-do-redisplay                ; "l"
                                         ;; ;; ":d", ":v", ":s", ":e"
                                         ;; ";" (lookup-key dired-mode-map ":")
                                         )
     )
  )


;; Don't default any buffers to insert mode
(setq evil-emacs-state-modes '(magit-popup-mode))
(setq evil-insert-state-modes nil)
;; Add help mode so `q' can quit the help buffer
(setq evil-motion-state-modes '(
                                dired-mode
                                help-mode
                                debugger-mode
                                magit-status-mode
                                ))

(provide 'robenkleene-evil-modes)
;;; robenkleene-evil-modes.el ends here
