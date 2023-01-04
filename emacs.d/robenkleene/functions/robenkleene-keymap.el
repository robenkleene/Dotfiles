;;; robenkleene-keymap.el --- robenkleene-keymap
;;; Commentary:
;;; Code:

(defun robenkleene/kill-region-or-backward-word ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, call `backward-kill-word'."
  (interactive)
  (call-interactively
   (if (use-region-p) 'kill-region 'backward-kill-word)))

(defvar-local robenkleene/archive-function nil)
(defun robenkleene/archive-and-delete ()
  "Archive the current file or region."
  (interactive)
  (if (bound-and-true-p robenkleene/archive-function)
      (call-interactively robenkleene/archive-function)
    (if (use-region-p)
        (progn
          (shell-command-on-region (region-beginning)
                                   (region-end)
                                   "~/.bin/backup_text -m")
          (delete-region (region-beginning) (region-end))
          )
      (robenkleene/archive-current-file))
    )
  )

(defun robenkleene/archive-region ()
  "Archive region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/backup_text -m")
    )
  )

(defun robenkleene/next ()
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
    (robenkleene/find-next-file)
    )
  )

(defun robenkleene/previous ()
  "Make a wiki link from a file named after the region."
  (interactive)
  (if
      (or
       (buffer-live-p (get-buffer "*grep*"))
       (buffer-live-p (get-buffer "*hgrep*"))
       (buffer-live-p (get-buffer "*hmoccur*"))
       )
      (previous-error)
    (robenkleene/find-next-file t)
    )
  )

(defun robenkleene/find-next-file (&optional backward)
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

(defun robenkleene/convert-region-to-title-case ()
  "Make a wiki link from a file named after the region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/title_case"
                               nil
                               t)
    )
  )

(defun robenkleene/forward-block (&optional n)
  "Move to next text block N."
  (interactive "p")
  (if (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" 1)
      (forward-line -1))
  )

(defun robenkleene/forward-block-select (&optional n)
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

(defun robenkleene/backward-block (&optional n)
  "Move cursor to previous text block N."
  (interactive "p")
  (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
      (forward-line)
    )
  )

(defun robenkleene/backward-block-select (&optional n)
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

(defun robenkleene/duplicate-line-below ()
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

(defun robenkleene/duplicate-line-above ()
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

(defun robenkleene/move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun robenkleene/move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun robenkleene/comment ()
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

(defun robenkleene/kill-region-or-window-map ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, use `robenkleene/window-map'."
  (interactive)
  (if (use-region-p)
      (call-interactively 'kill-region)
    (set-transient-map robenkleene/window-map)
    )
  )

(provide 'robenkleene-keymap)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-keymap.el ends here
