;;; robenkleene-keymap.el --- robenkleene-keymap
;;; Commentary:
;;; Code:

(defun rk/kill-region-or-backward-word ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, call `backward-kill-word'."
  (interactive)
  (call-interactively
   (if (use-region-p) 'kill-region 'backward-kill-word)))

(defvar-local rk/archive-function nil)
(defun rk/archive-and-delete ()
  "Archive the current file or region."
  (interactive)
  (if (bound-and-true-p rk/archive-function)
      (call-interactively rk/archive-function)
    (if (use-region-p)
        (progn
          (shell-command-on-region (region-beginning)
                                   (region-end)
                                   "~/.bin/backup_text -m")
          (delete-region (region-beginning) (region-end))
          )
      (rk/archive-current-file))
    )
  )

(defun rk/next ()
  "Make a wiki link from a file named after the region."
  (interactive)
  (if
      (or
       (buffer-live-p (get-buffer "*grep*"))
       (buffer-live-p (get-buffer "*hgrep*"))
       (buffer-live-p (get-buffer "*hmoccur*"))
       (buffer-live-p (get-buffer "*compilation*"))
       )
      (next-error)
    (rk/find-next-file)
    )
  )

(defun rk/previous ()
  "Make a wiki link from a file named after the region."
  (interactive)
  (if
      (or
       (buffer-live-p (get-buffer "*grep*"))
       (buffer-live-p (get-buffer "*hgrep*"))
       (buffer-live-p (get-buffer "*hmoccur*"))
       )
      (previous-error)
    (rk/find-next-file t)
    )
  )

(defun rk/find-next-file (&optional backward)
  "Find the next file in the current directory, optionally BACKWARD.

With prefix arg, find the previous file."
  (interactive "P")
  (when buffer-file-name
    (let* ((file (expand-file-name buffer-file-name))
           (files
            (cl-remove-if
             (lambda (file) (cl-first (file-attributes file)))
             (sort (directory-files
                    (file-name-directory file) t nil t) 'string<)))
           (pos
            (mod (+ (cl-position file files :test 'equal) (if backward -1 1))
                 (length files))))
      (find-file (nth pos files)))))

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


(defun rk/duplicate-line-below ()
  "Duplicate the current line."
  (interactive)
  (move-beginning-of-line 1)
  (if (use-region-p)
      (progn
        (kill-region (region-beginning) (region-end))
        (yank)
        )
    (progn
      (kill-line)
      (yank)
      (if (= (point-at-eol) (point))
          (progn
            (open-line 1)
            (forward-line 1))
        )
      )
    )
  (yank)
  )

(defun rk/duplicate-line-above ()
  "Duplicate the current line."
  (interactive)
  (move-beginning-of-line 1)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-line)
    )
  (yank)
  (if (= (point-at-eol) (point))
      (progn
        (open-line 1)
        (forward-line 1)
        )
    )
  (yank)
  )

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

(defun rk/comment ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line."
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let (($lbp (line-beginning-position))
          ($lep (line-end-position)))
      (if (eq $lbp $lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) $lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region $lbp $lep)
            (forward-line )))))))

(defun rk/kill-region-or-window-map ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, use `rk/window-map'."
  (interactive)
  (if (use-region-p)
      (call-interactively 'kill-region)
    (set-transient-map rk/window-map)
    )
  )

(provide 'robenkleene-keymap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-keymap.el ends here
