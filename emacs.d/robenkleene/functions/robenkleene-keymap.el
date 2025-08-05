;;; robenkleene-keymap.el --- robenkleene-keymap
;;; Commentary:
;;; Code:

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

(defun rk/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(defun rk/move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun rk/move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun rk/find-file (filename)
  "Like `find-file`, but if FILENAME is of the form 'path:line[:col]', jumps to that line and column."
  (interactive
   (list (read-file-name "Find file: ")))
  (let ((regex "\\`\$begin:math:text$.*?\\$end:math:text$:\$begin:math:text$[0-9]+\\$end:math:text$\$begin:math:text$?::\\\\([0-9]+\\$end:math:text$\\)?\\'"))
    (if (string-match regex filename)
        (let* ((file (match-string 1 filename))
               (line (string-to-number (match-string 2 filename)))
               (col (when (match-string 3 filename)
                      (string-to-number (match-string 3 filename)))))
          (find-file file)
          (goto-char (point-min))
          (forward-line (1- line))
          (when col
            (forward-char (1- col))))
      (find-file filename))))

(provide 'robenkleene-keymap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-keymap.el ends here
