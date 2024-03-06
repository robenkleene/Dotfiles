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

;; Mac OS

;; Kill

(defun grep-line ()
  "grep for current line."
  (interactive)
  (if buffer-file-name
      (let* (
             (path buffer-file-name)
             (line-number (number-to-string (line-number-at-pos)))
             (command (concat path ":" line-number))
             )
        (message "%s" command)
        command
        )
    ))

(defun rk/sgit-push-text-all ()
  "Commit everything in the current repository."
  (interactive)
  (shell-command "~/.bin/sgitt -cp")
  (other-window 1)
  )

(defun tags-refresh ()
  "Load the tags file relative to the current buffer."
  (interactive)
  (let ((tags-file (locate-dominating-file default-directory "TAGS")))
    (when tags-file
      (visit-tags-table tags-file)
      )
    )
  )

(defun pwd-safe ()
  "Return project root."
  (interactive)
  (if (daemonp)
      (let ((client (frame-parameter nil 'client)))
        (process-get client 'server-client-directory))
    (if (getenv "PWD")
        default-directory)
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

(defun rk/egit-update (&optional arg)
  "Run update."
  (interactive)
  (async-shell-command "~/.bin/egit_update" "*egit*" "*egit*")
  ;; (switch-to-buffer-other-window "*egit*")
  ;; (view-mode)
  )

(defun rk/git-pull-all-text (&optional arg)
  "Pull all text."
  (interactive)
  (async-shell-command "~/.bin/git_pull_all -t" "*egit*" "*egit*")
  ;; (switch-to-buffer-other-window "*egit*")
  ;; (view-mode)
  )

(defun rk/z (term)
  "Z directory."
  (shell-command-to-string (concat "zoxide query "
                                   term
                                   " | tr -d '\n'")
                           )
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

(defun make-frame-with-current-frame ()
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
         ;; (width (assoc-default 'width default-frame-alist))
         ;; (height (assoc-default 'height default-frame-alist))
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

(provide 'robenkleene-interactive)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-interactive.el ends here
