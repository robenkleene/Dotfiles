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

(defun cd-pwd ()
  "Got to the project root."
  (interactive)
  (find-file (rk/pwd))
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

;; Switch to

(defun scratch-window ()
  "Delete other windows and switch to scratch buffer."
  (interactive)
  (delete-other-windows)
  (switch-to-buffer "*scratch*")
  )

;; Slug Project

(defun slug-project-create (title dir)
  "Create a new slug project with TITLE in DIR."
  (interactive
   (list (read-from-minibuffer "Title: "
                               (if (use-region-p)
                                   (buffer-substring (mark) (point))
                                 nil
                                 ))
         (if current-prefix-arg
             (read-directory-name "Directory: ")
           (expand-file-name default-directory)
           )
         ))
  (let ((default-directory dir))
    (if (use-region-p)
        (shell-command-on-region (region-beginning)
                                 (region-end)
                                 (concat "~/.bin/slug_project -t "
                                         (shell-quote-argument title))
                                 nil
                                 t
                                 )
      (rk/safe-find-file
       (shell-command-to-string (concat "~/.bin/slug_project -f -t "
                                        (shell-quote-argument title))
                                )
       )
      )
    )
  )

(defun slug-project-archive-readme ()
  "Open slug project archive README."
  (interactive)
  (let ((file-path (concat default-directory "archive/README.md")))
    (if (file-exists-p file-path)
        (find-file file-path)
      )
    )
  )

(defun slug-project-archive ()
  "Archive slug project."
  (interactive)
  (if (file-exists-p (concat default-directory "../../archive/projects"))
      (if (y-or-n-p (concat "Archive "
                            (file-name-nondirectory
                             (directory-file-name default-directory)
                             )))
          (progn
            (shell-command-to-string
             (concat "~/.bin/slug_project_archive "
                     (shell-quote-argument
                      (expand-file-name default-directory)))
             )
            (kill-this-buffer)
            (rk/kill-removed-buffers)))
    )
  )

;; Region

(defun title-case-region ()
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

(defun backup-region ()
  "Backup region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/backup_text -m")
    )
  )

(defun archive-region ()
  "Backup and delete region."
  (interactive)
  (if (use-region-p)
      (progn
        (shell-command-on-region (region-beginning)
                                 (region-end)
                                 "~/.bin/backup_text -m")
        (delete-region (region-beginning) (region-end))
        )
    ))

;; Older

(defun rk/kill-removed-buffers ()
  "Kill buffers whose underlying file has moved."
  (interactive)
  (let
      ((to-kill
        (-remove 'rk/buffer-backed-by-file-p (buffer-list))))
    (mapc 'kill-buffer to-kill)
    (if (called-interactively-p 'extended-command)
        (message "Killed %s buffers" (length to-kill))
      )
    ))

(defun rk/sgit-push-text-all ()
  "Commit everything in the current repository."
  (interactive)
  (shell-command "~/.bin/sgitt -cp")
  (other-window 1)
  )

(defun rk/archive-this-buffer ()
  "Archive the current file."
  (interactive)
  (if (y-or-n-p (concat "Backup " (buffer-name)))
      (if (buffer-file-name)
          (progn
            (message (shell-command-to-string
                      (concat "~/.bin/backup_file "
                              (shell-quote-argument buffer-file-name))
                      ))
            (kill-this-buffer)
            )
        (progn
          (shell-command-on-region
           (point-min)
           (point-max)
           "~/.bin/backup_text -m")
          (kill-this-buffer)
          )
        )
    )
  )

(defun rk/generate-tags ()
  "Generate tags."
  (interactive)
  (compile "~/.bin/generate_tags -e"))

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

(defun rk/xcode-open-file ()
  "Open file in Xcode."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -a \"Xcode\" "
                             (shell-quote-argument buffer-file-name))
                     )
    )
  )

(defun eshell-other-window ()
  "Open eshell in other window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf))
  )

(defun rk/yank-to-grep-buffer-startup ()
  "Yank to grep buffer deleting other window."
  (interactive)
  (yank-to-grep-buffer)
  (delete-other-windows)
  )

(defun rk/yank-to-diff-buffer-startup ()
  "Yank to diff buffer deleting other window."
  (interactive)
  (yank-to-diff-buffer)
  (delete-other-windows)
  )

(defun rk/yank-to-virtual-dired-buffer-startup ()
  "Yank to diff buffer deleting other window."
  (interactive)
  (yank-to-diff-buffer)
  (delete-other-windows)
  )

(defun yank-to-grep-buffer ()
  "Yank to grep buffer."
  (interactive)
  (require 'grep)
  (add-hook 'compilation-finish-functions 'rk/compilation-next-once)
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

(defun yank-to-virtual-dired-buffer (&optional arg)
  "Yank to virtual dired buffer."
  (interactive)
  (switch-to-buffer
   (generate-new-buffer "*virtual dired yank*"))
  (yank)
  (dired-virtual default-directory)
  (beginning-of-buffer)
  )

(defvar-local rk/format-program nil)
(defvar-local rk/format-function nil)
(defun rk/format ()
  "Run buffer or region through format program."
  (interactive)
  (if (bound-and-true-p rk/format-function)
      (call-interactively rk/format-function)
    (if (bound-and-true-p rk/format-program)
        (rk/shell-command-on-buffer-or-region
         rk/format-program)
      (message "No format program defined.")
      )
    )
  )

(defvar-local rk/evaluate-buffer-or-region-function nil)
(defun rk/evaluate-buffer-or-region ()
  "Evaluate the buffer or region."
  (interactive)
  (if (bound-and-true-p rk/evaluate-buffer-or-region-function)
      (call-interactively rk/evaluate-buffer-or-region-function)
    (message "No evaluate function defined.")
    )
  )

(defvar-local rk/run-compile-program nil)
(defun rk/run ()
  "Run buffer or region through format program."
  (interactive)
  (compile (concat rk/run-compile-program
                   " "
                   (shell-quote-argument buffer-file-name)))
  )

(defun rk/shell-command-on-buffer-or-region (command)
  "Pipe the current buffer or region through COMMAND."
  (interactive "r")
  (if (use-region-p)
      (progn
        (shell-command-on-region (region-beginning) (region-end) command nil t)
        (deactivate-mark)
        )
    (let ((p (point)))
      (save-excursion
        (shell-command-on-region (point-min) (point-max) command nil t)
        )
      (goto-char p)
      )
    )
  )

(defun rk/make-scratch-frame ()
  "Make a new frame and go to the scratch buffer."
  (interactive)
  (let ((frame (make-frame)))
    (select-frame-set-input-focus frame)
    (switch-to-buffer "*scratch*")))

(defun rk/make-scratch-frame-with-current-frame ()
  "Make a new scratch frame the same size as the current frame."
  (interactive)
  (rk/make-frame-with-current-frame)
  (switch-to-buffer "*scratch*")
  )

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

(defun grep-toggle-buffer ()
  "Toggle grep buffer."
  (interactive)

  (if (get-buffer "*grep*")
      (let ((win (get-buffer-window "*grep*" 'visible)))
        (if win
            (delete-window win)
          (switch-to-buffer-other-window "*grep*")
          )
        )
    )
  )

(defun vc-cd-vc-root ()
  "Go to root directory for current repo."
  (interactive)
  (find-file (vc-root-dir))
  )

(defun clear ()
  "Clear everything."
  (interactive)
  (desktop-clear)
  (tab-close-group "")
  )

(defun z (term)
  "Jump to directory."
  (interactive
   (list (read-from-minibuffer "Z: ")
         ))
  (rk/safe-find-file
   (shell-command-to-string (concat "~/.bin/z_get "
                                    term)
                            )
   )
  )

(provide 'robenkleene-interactive)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-interactive.el ends here
