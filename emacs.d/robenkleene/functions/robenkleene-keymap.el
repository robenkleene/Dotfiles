;;; robenkleene-keymap.el --- robenkleene-keymap
;;; Commentary:
;;; Code:

(defun rk/make-frame-with-current-frame ()
  "Make a new frame the same size as the current frame."
  (interactive)
  (let* ((frame (selected-frame))
         (left (frame-parameter frame 'left))
         (left (if (consp left)
                   (eval left)
                 left))
         (top (frame-parameter frame 'top))
         (width (frame-width frame))
         (height (frame-height frame))
         )
    (let ((frame (make-frame
                  `(
                    (left . ,(+ left 30))
                    (top . ,(+ top 30))
                    (width . ,width)
                    (height . ,height)
                    ))))
      (select-frame-set-input-focus frame))
    )
  )

(defun rk/forward-block (&optional n)
  "Move to next text block N."
  (interactive "p")
  (if (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" 1)
      (forward-line -1))
  )

(defun rk/forward-block-select (&optional n)
  "Move to next text block N."
  (interactive "p")

  ;; (setq this-command-keys-shift-translated t)
  (if (not (use-region-p))
      (set-mark-command nil)
    )

  ;; For some reason this messes up the selection so hitting `⇧↑' restarts the
  ;; region
  (if (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" 1)
      (forward-line -1))
  )

(defun rk/backward-block (&optional n)
  "Move cursor to previous text block N."
  (interactive "p")
  (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
      (forward-line)
    )
  )

(defun rk/backward-block-select (&optional n)
  "Move cursor to previous text block N."
  (interactive "p")
  (if (not (use-region-p))
      (set-mark-command nil)
    )

  ;; (setq this-command-keys-shift-translated t)
  ;; For some reason this messes up the selection so hitting `⇧↓' restarts the
  ;; region
  (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
      (forward-line)
    )
  )

;; (defvar block-repeat-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "{") #'rk/backward-block)
;;     (define-key map (kbd "}") #'rk/forward-block)
;;     (define-key map (kbd "[") #'rk/backward-block)
;;     (define-key map (kbd "]") #'rk/forward-block)
;;     map))
;; (dolist (cmd '(rk/backward-block rk/forward-block))
;;   (put cmd 'repeat-map 'block-repeat-map))

(provide 'robenkleene-keymap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-keymap.el ends here
