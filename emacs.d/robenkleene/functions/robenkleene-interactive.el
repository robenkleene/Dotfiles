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

(defun repla-open-file ()
  "Open file in Repla."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "repla "
                             (shell-quote-argument buffer-file-name))
                     )
    )
  )

(defun reveal-in-finder ()
  "Open a new Finder window at the current path."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -R "
                             (shell-quote-argument buffer-file-name))
                     )
    (shell-command "open .")
    )
  )

;; Cd

(defun cd-hg ()
  "Got to the project root."
  (interactive)
  (let ((dir (shell-command-to-string
              "hg root 2> /dev/null | tr -d '\n'")))
    (if dir
        (find-file dir)
      )
    )
  )

(defun cd-git ()
  "Got to the project root."
  (interactive)
  (let ((dir (shell-command-to-string
              "git rev-parse --show-toplevel 2> /dev/null | tr -d '\n'")))
    (if dir
        (find-file dir)
      )
    )
  )



;; Kill

(defun kill-buffer-file-name ()
  "Copy the filename to the kill ring."
  (interactive)
  (if buffer-file-name
      (progn
        (message buffer-file-name)
        (kill-new buffer-file-name)
        )
    (progn
      (message default-directory)
      (kill-new default-directory)
      )
    )
  )
(defalias 'kill-buffer-file-path 'kill-buffer-file-name)

(defun rk/kill-buffer-name ()
  "Kill `buffer-name'"
  (interactive)
  (message (buffer-name))
  (kill-new (buffer-name))
  )

(defun kill-default-directory ()
  "Kill `default-directory'."
  (interactive)
  (message default-directory)
  (kill-new default-directory))

(defun kill-today ()
  "Kill the today's date."
  (interactive)
  (message (rk/date-today))
  (kill-new (rk/date-today)))

(defun kill-grep ()
  "Kill grep."
  (interactive)
  (if buffer-file-name
      (let* (
             (path buffer-file-name)
             (line-number (number-to-string (line-number-at-pos)))
             (command (concat path ":" line-number))
             )
        (message "%s" command)
        (kill-new command)
        )
    ))

(defun rk/sgit-push-text-all ()
  "Commit everything in the current repository."
  (interactive)
  (shell-command "~/.bin/sgitt -cp")
  (other-window 1)
  )

(defun rk/refresh-tags ()
  "Load the tags file relative to the current buffer."
  (interactive)
  (let ((tags-file (locate-dominating-file default-directory "TAGS")))
    (when tags-file
      (visit-tags-table tags-file)
      )
    )
  )

(defun rk/pwd ()
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

(defun z (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file-other-window
   (shell-command-to-string (concat "~/.bin/z_get "
                                    term)
                            )
   )
  )

(defun z-add ()
  "Add file or directory."
  (if (executable-find "z_add")
      (let ((file default-directory))
        (when (and file
                   (stringp file)
                   (file-readable-p file))
          (start-process "*z add*" nil "z_add" (expand-file-name file))))))

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
