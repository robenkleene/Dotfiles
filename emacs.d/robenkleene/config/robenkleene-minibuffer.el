;;; robenkleene-minibuffer.el --- robenkleene-minibuffer
;;; Commentary:
;;; Code:

;; Persist minibuffer history between restarts (packages like `vertico' will use
;; this to prioritized commonly used commands)
(savehist-mode)

(with-eval-after-load "minibuffer"
  ;; Copies of `next-line-or-history-element' and
  ;; `previous-line-or-history-element' that call
  ;; `next-complete-history-element' and `previous-complete-history-element'
  ;; (instead of `next-history-element' and `previous-history-element')
  (defun rk/next-line-or-complete-history-element (&optional arg)
    "Move cursor vertically down ARG lines, or to the next history element.
When point moves over the bottom line of multi-line minibuffer, puts ARGth
next element of the minibuffer history in the minibuffer."
    (interactive "^p")
    (or arg (setq arg 1))
    (let* ((old-point (point))
           ;; Don't add newlines if they have the mode enabled globally.
           (next-line-add-newlines nil)
           ;; Remember the original goal column of possibly multi-line input
           ;; excluding the length of the prompt on the first line.
           (prompt-end (minibuffer-prompt-end))
           (old-column (unless (and (eolp) (> (point) prompt-end))
                         (if (= (line-number-at-pos) 1)
                             (max (- (current-column)
                                     (save-excursion
                                       (goto-char (1- prompt-end))
                                       (current-column)))
                                  0)
                           (current-column)))))
      (condition-case nil
          (with-no-warnings
            (next-line arg))
        (end-of-buffer
         ;; Restore old position since `line-move-visual' moves point to
         ;; the end of the line when it fails to go to the next line.
         (goto-char old-point)
         (next-complete-history-element arg)
         ;; Reset `temporary-goal-column' because a correct value is not
         ;; calculated when `next-line' above fails by bumping against
         ;; the bottom of the minibuffer (bug#22544).
         (setq temporary-goal-column 0)
         ;; Restore the original goal column on the last line
         ;; of possibly multi-line input.
         (goto-char (point-max))
         (when old-column
           (if (= (line-number-at-pos) 1)
               (move-to-column (+ old-column
                                  (save-excursion
                                    (goto-char (1- (minibuffer-prompt-end)))
                                    (current-column))))
             (move-to-column old-column)))))))
  (defun rk/previous-line-or-complete-history-element (&optional arg)
    "Move cursor vertically up ARG lines, or to the previous history element.
When point moves over the top line of multi-line minibuffer, puts ARGth
previous element of the minibuffer history in the minibuffer."
    (interactive "^p")
    (or arg (setq arg 1))
    (let* ((old-point (point))
           ;; Remember the original goal column of possibly multi-line input
           ;; excluding the length of the prompt on the first line.
           (prompt-end (minibuffer-prompt-end))
           (old-column (unless (and (eolp) (> (point) prompt-end))
                         (if (= (line-number-at-pos) 1)
                             (max (- (current-column)
                                     (save-excursion
                                       (goto-char (1- prompt-end))
                                       (current-column)))
                                  1)
                           (current-column)))))
      (condition-case nil
          (with-no-warnings
            (previous-line arg)
            ;; Avoid moving point to the prompt
            (when (< (point) (minibuffer-prompt-end))
              ;; If there is minibuffer contents on the same line
              (if (<= (minibuffer-prompt-end)
                      (save-excursion
                        (if (or truncate-lines (not line-move-visual))
                            (end-of-line)
                          (end-of-visual-line))
                        (point)))
                  ;; Move to the beginning of minibuffer contents
                  (goto-char (minibuffer-prompt-end))
                ;; Otherwise, go to the previous history element
                (signal 'beginning-of-buffer nil))))
        (beginning-of-buffer
         ;; Restore old position since `line-move-visual' moves point to
         ;; the beginning of the line when it fails to go to the previous line.
         (goto-char old-point)
         (previous-complete-history-element arg)
         ;; Reset `temporary-goal-column' because a correct value is not
         ;; calculated when `previous-line' above fails by bumping against
         ;; the top of the minibuffer (bug#22544).
         (setq temporary-goal-column 0)
         ;; Restore the original goal column on the first line
         ;; of possibly multi-line input.
         (goto-char (minibuffer-prompt-end))
         (if old-column
             (if (= (line-number-at-pos) 1)
                 (move-to-column (+ old-column
                                    (save-excursion
                                      (goto-char (1- (minibuffer-prompt-end)))
                                      (current-column))))
               (move-to-column old-column))
           (if (not line-move-visual) ; Handle logical lines (bug#42862)
               (end-of-line)
             ;; Put the cursor at the end of the visual line instead of the
             ;; logical line, so the next `previous-line-or-history-element'
             ;; would move to the previous history element, not to a possible upper
             ;; visual line from the end of logical line in `line-move-visual' mode.
             (end-of-visual-line)
             ;; Since `end-of-visual-line' puts the cursor at the beginning
             ;; of the next visual line, move it one char back to the end
             ;; of the first visual line (bug#22544).
             (unless (eolp) (backward-char 1))))))))

  (define-key minibuffer-local-map (kbd "<up>") 'rk/previous-line-or-complete-history-element)
  (define-key minibuffer-local-map (kbd "<down>") 'rk/next-line-or-complete-history-element)
  )

;; Enable recursive minibuffers so `C-u M-! <command>' can be used when naming
;; files.
;; This fixes an issue where using `M-!' (`M-x shell-command') printed an error
;; when using Terminal Emacs through `emacsclient'
;; This breaks using `M-n' after `M-!' to run a shell command on the current
;; buffer
;; Try disabling recursive minibuffers, in practice it's really confusing
;; (setq enable-recursive-minibuffers t)

(provide 'robenkleene-minibuffer)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-minibuffer.el ends here
