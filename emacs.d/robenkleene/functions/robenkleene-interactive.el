;;; robenkleene-interactive.el --- robenkleene-interactive.el
;;; Commentary:
;;; Code:

;; Live

(defun rg (regexp &optional files dir)
  "Search for REGEXP with optional FILES and DIR."
  (interactive (rk/grep-parameters))
  (require 'grep)
  (let ((default-directory (or dir default-directory))
        (command (grep-expand-template
                  (if (equal files nil)
                      rk/rg-command
                    rk/rg-command-files)
                  regexp
                  files))
        )
    (compilation-start command 'grep-mode)
    )
  )

(defun eshell-other-window ()
  "Open eshell in other window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf))
  )

(defun yank-to-grep-buffer ()
  "Yank to grep buffer."
  (interactive)
  (require 'grep)
  (compilation-start "safepaste" 'grep-mode)
  )

(defun yank-to-diff-buffer (&optional arg)
  "Yank to diff buffer."
  (interactive)
  (switch-to-buffer
   (generate-new-buffer "*diff yank*"))
  (yank)
  (diff-mode)
  (beginning-of-buffer)
  (diff-file-next)
  )

(defun z (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file
   (rk/z term)
   )
  )

(defun z-other-window (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file-other-window
   (rk/z term)
   )
  )

(defun z-other-tab (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file-other-tab
   (rk/z term)
   )
  )

(defun z-other-frame (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file-other-frame
   (rk/z term)
   )
  )

(provide 'robenkleene-interactive)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-interactive.el ends here
