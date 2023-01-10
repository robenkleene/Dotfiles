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

(defun open-in-repla ()
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

;; Switch to

(defun inbox ()
  "Switch to inbox directory."
  (interactive)
  (find-file "~/Documents/Text/Notes/Inbox/")
  )

(defun projects ()
  "Switch to projects directory."
  (interactive)
  (find-file "~/Documents/Text/Notes/Projects/")
  )

(defun notes ()
  "Switch to notes directory."
  (interactive)
  (find-file "~/Documents/Text/Notes/")
  )

(defun text ()
  "Switch to text directory."
  (interactive)
  (find-file "~/Text/")
  )

(defun archive ()
  "Switch to archive directory."
  (interactive)
  (find-file "~/Archive/Text/")
  )

(defun daily ()
  "Switch to daily file."
  (interactive)
  (rk/safe-find-file
   (shell-command-to-string "~/.bin/daily_file -b"))
  )

(defun scratch ()
  "Switch to scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*")
  )

(defun messages ()
  "Switch to messages buffer."
  (interactive)
  (switch-to-buffer "*Messages*")
  )

;; Kill

(defun kill-buffer-file-name ()
  "Copy the filename to the kill ring."
  (interactive)
  (message (buffer-file-name))
  (kill-new (buffer-file-name))
  )

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

;; Text

(defun daily-create ()
  "Switch to daily file, creating it if missing."
  (interactive)
  (rk/safe-find-file
   (shell-command-to-string "~/.bin/daily_file"))
  )

(defun inbox-create (title)
  "Create a new inbox document with TITLE."
  (interactive (list (read-from-minibuffer "Title: "
                                           (if (use-region-p)
                                               (buffer-substring (mark) (point))
                                             nil
                                             ))
                     ))
  (rk/safe-find-file
   (shell-command-to-string (concat "~/.bin/inbox_new "
                                    (shell-quote-argument title))
                            ))
  )

(defun projects-create (title)
  "Create a new projects document with TITLE."
  (interactive (list (read-from-minibuffer "Title: "
                                           (if (use-region-p)
                                               (buffer-substring (mark) (point))
                                             nil
                                             ))
                     ))
  (rk/safe-find-file
   (shell-command-to-string (concat "~/.bin/projects_new "
                                    (shell-quote-argument title))
                            ))
  )

(defun untitled-create ()
  "Open a new Untitled buffer."
  (interactive)
  (switch-to-buffer (rk/create-untitled-buffer))
  )

(defun untitled ()
  "Open a new Untitled buffer."
  (interactive)
  (find-file (concat user-emacs-directory "untitled/"))
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
                                 (concat "~/.bin/slug_project -l -t "
                                         (shell-quote-argument title))
                                 nil
                                 t
                                 )
      (rk/safe-find-file
       (shell-command-to-string (concat "~/.bin/slug_project -t "
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

(defun rk/open-terminal-window ()
  "Open a new Terminal window at the current path."
  (interactive)
  (shell-command "open -a Terminal .")
  )

(defun rk/open-in-writer ()
  "Open file in iA Writer."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -a \"iA Writer.app\" "
                             (shell-quote-argument buffer-file-name))
                     )
    )
  )

(defun rk/new-clipboard ()
  "Switch a new buffer with the clipboard contents."
  (interactive)
  (switch-to-buffer (rk/create-untitled-buffer))
  (yank)
  )


(defun rk/open-home ()
  "Open home directory."
  (interactive)
  (find-file "~/")
  )

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

(defun rk/urls-open ()
  "Open URLs in the region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/urls_open")
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

(defun rk/open-in-xcode ()
  "Open file in Xcode."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -a \"Xcode\" "
                             (shell-quote-argument buffer-file-name))
                     )
    )
  )

(defun rk/other-window-shell ()
  "Open shell in other window."
  (interactive)
  (switch-to-buffer-other-window "*shell*")
  (shell))

(defun rk/other-window-eshell ()
  "Open eshell in other window."
  (interactive)
  (switch-to-buffer-other-window "*eshell*")
  (eshell))

(defvar rk/scratch-directory-path "~/Developer/Scratch/Source/")
(defvar rk/scratch-file-name "source")
(defun rk/scratch-for-buffer ()
  "Open scratch file for current buffer."
  (interactive)
  (let ((extension (file-name-extension (buffer-file-name))))
    (if extension
        (let ((scratch-file-name
               (format "%s%s.%s"
                       rk/scratch-directory-path
                       rk/scratch-file-name
                       extension
                       )
               )
              )
          (find-file-other-window scratch-file-name)
          )
      )
    )
  )

(defun rk/switch-to-scratch-other-window ()
  "Switch to scratch for current buffer in other window."
  (interactive)
  (let ((file (rk/scratch-for-file (buffer-file-name))))
    (if (bound-and-true-p file)
        (find-file-other-window file)
      (message "No file found.")
      )
    )
  )


(defvar
  rk/documentation-directory-path
  "~/Documentation/")

(defun rk/documentation-view ()
  "View documentation."
  (interactive)
  (view-file
   (rk/documentation-file))
  )

(defun rk/documentation-edit ()
  "Edit documentation."
  (interactive)
  (find-file
   (rk/documentation-file-or-dir))
  )

(defun rk/documentation-other-window ()
  "View documentation in other window."
  (interactive)
  (view-file-other-window
   (rk/documentation-file))
  )

(defun rk/documentation-edit-other-window ()
  "Edit documentation in other window."
  (interactive)
  (find-file-other-window
   (rk/documentation-file))
  )

(defun rk/grep-from-clipboard ()
  "Grep buffer with clipboard."
  (interactive)
  (require 'grep)
  (add-hook 'compilation-finish-functions 'rk/compilation-next-once)
  ;; (add-hook 'compilation-finish-functions 'rk/compilation-hide-once)
  (compilation-start "safepaste" 'grep-mode)
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

(defun rk/open-scratch-for-file ()
  "Switch to scratch file for current buffer."
  (interactive)
  (let ((file (rk/scratch-for-file (buffer-file-name))))
    (if (bound-and-true-p file)
        (find-file file)
      (message "No file found.")
      )
    )
  )

(defun rk/scratch-for-file (file)
  "Return the path to the scratch file for FILE."
  (let ((extension (file-name-extension file))
        (scratch-directory "~/Developer/Scratch/Document/")
        directories
        file)
    (if (bound-and-true-p extension)
        (setq directories
              (directory-files scratch-directory
                               nil
                               (concat "^[^.].*\." extension)))
      (message "No valid extension found.")
      )
    (expand-file-name (car directories) scratch-directory)
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
         ;; (width (frame-width frame))
         ;; (height (frame-height frame))
         (width (assoc-default 'width default-frame-alist))
         (height (assoc-default 'height default-frame-alist))
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
  (async-shell-command "~/.bin/egit_update" "*egit update*" "*egit update*")
  (switch-to-buffer-other-window "*egit update*")
  (view-mode)
  )

(defun rk/toggle-grep-buffer ()
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

(provide 'robenkleene-interactive)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-interactive.el ends here
