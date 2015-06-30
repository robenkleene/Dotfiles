;;; robenkleene-functions.el --- robenkleene-functions
;;; Commentary:
;;; Code:

(defun robenkleene/dired-jump ()
  "Require dired and jump."
  (interactive)
  (require 'dired)
  (dired-jump)
  )

(defun robenkleene/backward-delete-line (arg)
  "Delete the line without clobbering the clipboard.  ARG is discarded."
  (interactive "p")
  (delete-region (point) (progn (move-beginning-of-line arg) (point))))

(defun robenkleene/backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(defun robenkleene/kill-region-or-backward-word ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, call `backward-kill-word'."
  (interactive)
  (call-interactively
   (if (use-region-p) 'kill-region 'robenkleene/backward-delete-word)))

(defun robenkleene/open-terminal-window ()
  "Open a new Terminal window at the current path."
  (interactive)
  (shell-command "open -a Terminal .")
  )
(defun robenkleene/open-finder-window ()
  "Open a new Finder window at the current path."
  (interactive)
  (shell-command "open .")
  )

(require 's)
(defun robenkleene/isearch-delete-word ()
  "Delete word in the `isearch-string'.  Splitting strings by whitespace, dashes, underscores and camelcase."
  (interactive)
  (let* ((isearch-regexp )
         (str (s-with (s-trim-right isearch-string)
                (s-chop-suffixes '("-" "-" "_" "*" "+" "."))))
         (trm (- (length str)
                 (length (car (last (s-split-words str))))))
         (string (substring str 0 trm)))
    (setq isearch-string nil
          isearch-message nil)
    (isearch-yank-string string)))

(defun robenkleene/isearch-delete-line (&optional arg)
  "Delete line, ARG is ignored."
  (interactive "p")
  (if (= 0 (length isearch-string))
      (ding)
    (setq isearch-string ""
          isearch-message (mapconcat 'isearch-text-char-description
                                     isearch-string "")))
  (if isearch-other-end (goto-char isearch-other-end))
  (isearch-search)
  (isearch-push-state)
  (isearch-update))

(defmacro robenkleene/rsify (mode map)
  "Hurt your hands in MODE and MAP."
  `(eval-after-load ,mode
     '(progn
        (define-key ,map (kbd "C-w") 'robenkleene/backward-delete-word)
        (define-key ,map (kbd "C-u") 'robenkleene/backward-delete-line)
        )
     )
  )


(provide 'robenkleene-functions)
;;; robenkleene-functions.el ends here
