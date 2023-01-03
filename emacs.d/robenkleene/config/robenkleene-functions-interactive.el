;;; robenkleene-functions-interactive.el --- robenkleene-functions-interactive.el
;;; Commentary:
;;; Code:

(defun robenkleene/edit-init ()
  "Edit init."
  (interactive)
  (find-file "~/.emacs.d/robenkleene/robenkleene.el")
  )

(defun robenkleene/open-terminal-window ()
  "Open a new Terminal window at the current path."
  (interactive)
  (shell-command "open -a Terminal .")
  )

(defun robenkleene/open-in-writer ()
  "Open file in iA Writer."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -a \"iA Writer.app\" "
                             (shell-quote-argument buffer-file-name))
                     )
    )
  )

(defun robenkleene/open-in-repla ()
  "Open file in Repla."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "repla "
                             (shell-quote-argument buffer-file-name))
                     )
    )
  )

(defun robenkleene/switch-to-empty-buffer-other-frame ()
  "Open a new frame with a buffer named Untitled."
  (interactive)
  (switch-to-buffer-other-frame (robenkleene/new-empty-buffer))
  )

(defun robenkleene/switch-to-empty-buffer ()
  "Open a new buffer named Untitled."
  (interactive)
  (switch-to-buffer (robenkleene/new-empty-buffer))
  )

(defun robenkleene/new-clipboard ()
  "Switch a new buffer with the clipboard contents."
  (interactive)
  (switch-to-buffer (robenkleene/new-empty-buffer))
  (yank)
  )

(defun robenkleene/switch-to-empty-buffer-other-window ()
  "Open a new window with a buffer named Untitled."
  (interactive)
  (switch-to-buffer-other-window (robenkleene/new-empty-buffer))
  )

(defun robenkleene/switch-to-empty-buffer-other-window-right ()
  "Open a new window with a buffer named Untitled."
  (interactive)
  (split-window-right)
  (other-window 1)
  (switch-to-buffer (robenkleene/new-empty-buffer))
  )

(defun robenkleene/reveal-in-finder ()
  "Open a new Finder window at the current path."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -R "
                             (shell-quote-argument buffer-file-name))
                     )
    (shell-command "open .")
    )
  )

(defun robenkleene/slug-project-create (title dir)
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
      (robenkleene/safe-find-file
       (shell-command-to-string (concat "~/.bin/slug_project -t "
                                        (shell-quote-argument title))
                                )
       )
      )
    )
  )

(defun robenkleene/slug-project-archive-readme ()
  "Open slug project archive README."
  (interactive)
  (let ((file-path (concat default-directory "archive/README.md")))
    (if (file-exists-p file-path)
        (find-file file-path)
      )
    )
  )

(defun robenkleene/slug-project-archive ()
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
            (robenkleene/kill-removed-buffers)))
    )
  )

(defun robenkleene/open-home ()
  "Open home directory."
  (interactive)
  (find-file "~/")
  )

(defun robenkleene/kill-removed-buffers ()
  "Kill buffers whose underlying file has moved."
  (interactive)
  (let
      ((to-kill
        (-remove 'robenkleene/buffer-backed-by-file-p (buffer-list))))
    (mapc 'kill-buffer to-kill)
    (if (called-interactively-p 'extended-command)
        (message "Killed %s buffers" (length to-kill))
      )
    ))

(defun robenkleene/sgit-push-text-all ()
  "Commit everything in the current repository."
  (interactive)
  (shell-command "~/.bin/sgitt -cp")
  (other-window 1)
  )

(defun robenkleene/archive-this-buffer ()
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

(defun robenkleene/urls-open ()
  "Open URLs in the region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/urls_open")
    )
  )

(defun robenkleene/generate-tags ()
  "Generate tags."
  (interactive)
  (compile "~/.bin/generate_tags -e"))

(defun robenkleene/refresh-tags ()
  "Load the tags file relative to the current buffer."
  (interactive)
  (let ((tags-file (locate-dominating-file default-directory "TAGS")))
    (when tags-file
      (visit-tags-table tags-file)
      )
    )
  )

(defun robenkleene/hg-cd ()
  "Got to the project root."
  (interactive)
  (let ((dir (shell-command-to-string
              "hg root 2> /dev/null | tr -d '\n'")))
    (if dir
        (find-file dir)
      )
    )
  )

(defun robenkleene/git-cd ()
  "Got to the project root."
  (interactive)
  (let ((dir (shell-command-to-string
              "git rev-parse --show-toplevel 2> /dev/null | tr -d '\n'")))
    (if dir
        (find-file dir)
      )
    )
  )

(defun robenkleene/pwd-cd ()
  "Got to the project root."
  (interactive)
  (find-file (robenkleene/pwd))
  )

(defun robenkleene/pwd ()
  "Return project root."
  (interactive)
  (if (daemonp)
      (let ((client (frame-parameter nil 'client)))
        (process-get client 'server-client-directory))
    (if (getenv "PWD")
        default-directory)
    )
  )

(defun robenkleene/open-in-xcode ()
  "Open file in Xcode."
  (interactive)
  (if (buffer-file-name)
      (shell-command (concat "open -a \"Xcode\" "
                             (shell-quote-argument buffer-file-name))
                     )
    )
  )

(defun robenkleene/other-window-shell ()
  "Open shell in other window."
  (interactive)
  (switch-to-buffer-other-window "*shell*")
  (shell))

(defun robenkleene/other-window-eshell ()
  "Open eshell in other window."
  (interactive)
  (switch-to-buffer-other-window "*eshell*")
  (eshell))

(defvar robenkleene/scratch-directory-path "~/Developer/Scratch/Source/")
(defvar robenkleene/scratch-file-name "source")
(defun robenkleene/scratch-for-buffer ()
  "Open scratch file for current buffer."
  (interactive)
  (let ((extension (file-name-extension (buffer-file-name))))
    (if extension
        (let ((scratch-file-name
               (format "%s%s.%s"
                       robenkleene/scratch-directory-path
                       robenkleene/scratch-file-name
                       extension
                       )
               )
              )
          (find-file-other-window scratch-file-name)
          )
      )
    )
  )

(defvar
  robenkleene/documentation-directory-path
  "~/Documentation/")

(defun robenkleene/documentation-view ()
  "View documentation."
  (interactive)
  (view-file
   (robenkleene/documentation-file))
  )

(defun robenkleene/documentation-edit ()
  "Edit documentation."
  (interactive)
  (find-file
   (robenkleene/documentation-file-or-dir))
  )

(defun robenkleene/documentation-other-window ()
  "View documentation in other window."
  (interactive)
  (view-file-other-window
   (robenkleene/documentation-file))
  )

(defun robenkleene/documentation-edit-other-window ()
  "Edit documentation in other window."
  (interactive)
  (find-file-other-window
   (robenkleene/documentation-file))
  )

(defun robenkleene/source-control-open-web (&optional arg)
  "Open the source control website for the current repository with ARG."
  (interactive)
  (shell-command (concat "~/.bin/source_control_open_site "
                         arg)
                 )
  )

(defun robenkleene/rg (regexp &optional files dir)
  "Search for REGEXP with optional FILES and DIR."
  (interactive (robenkleene/grep-parameters))
  (require 'grep)
  (let ((default-directory (or dir default-directory))
        (command (grep-expand-template
                  (if (equal files nil)
                      robenkleene/rg-command
                    robenkleene/rg-command-files)
                  regexp
                  files))
        )
    (compilation-start command 'grep-mode)
    )
  )

(defun robenkleene/grep-from-clipboard ()
  "Grep buffer with clipboard."
  (interactive)
  (require 'grep)
  (add-hook 'compilation-finish-functions 'robenkleene/compilation-next-once)
  ;; (add-hook 'compilation-finish-functions 'robenkleene/compilation-hide-once)
  (compilation-start "safepaste" 'grep-mode)
  )

(defvar-local robenkleene/format-program nil)
(defvar-local robenkleene/format-function nil)
(defun robenkleene/format ()
  "Run buffer or region through format program."
  (interactive)
  (if (bound-and-true-p robenkleene/format-function)
      (call-interactively robenkleene/format-function)
    (if (bound-and-true-p robenkleene/format-program)
        (robenkleene/shell-command-on-buffer-or-region
         robenkleene/format-program)
      (message "No format program defined.")
      )
    )
  )

(defvar-local robenkleene/evaluate-buffer-or-region-function nil)
(defun robenkleene/evaluate-buffer-or-region ()
  "Evaluate the buffer or region."
  (interactive)
  (if (bound-and-true-p robenkleene/evaluate-buffer-or-region-function)
      (call-interactively robenkleene/evaluate-buffer-or-region-function)
    (message "No evaluate function defined.")
    )
  )

(defvar-local robenkleene/run-compile-program nil)
(defun robenkleene/run ()
  "Run buffer or region through format program."
  (interactive)
  (compile (concat robenkleene/run-compile-program
                   " "
                   (shell-quote-argument buffer-file-name)))
  )

(defun robenkleene/shell-command-on-buffer-or-region (command)
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

(defun robenkleene/inbox-create-or-open ()
  "Switch to inbox directory or make new inbox document."
  (interactive)
  (if current-prefix-arg
      (call-interactively 'robenkleene/new-inbox-document)
    (robenkleene/inbox-open)
    )
  )

(defun robenkleene/switch-to-inbox ()
  "Switch to inbox directory."
  (interactive)
  (find-file "~/Documents/Text/Notes/Inbox/")
  )

(defun robenkleene/switch-to-notes ()
  "Switch to notes directory."
  (interactive)
  (find-file "~/Documents/Text/Notes/")
  )

(defun robenkleene/switch-to-text ()
  "Switch to text directory."
  (interactive)
  (find-file "~/Text/")
  )

(defun robenkleene/switch-to-archive ()
  "Switch to archive directory."
  (interactive)
  (find-file "~/Archive/Text/")
  )

(defun robenkleene/daily-create ()
  "Switch to daily file, creating it if missing."
  (interactive)
  (robenkleene/safe-find-file
   (shell-command-to-string "~/.bin/daily_file"))
  )

(defun robenkleene/daily ()
  "Switch to daily file."
  (interactive)
  (robenkleene/safe-find-file
   (shell-command-to-string "~/.bin/daily_file -b"))
  )

(defun robenkleene/inbox-create (title)
  "Create a new inbox document with TITLE at DIR."
  (interactive (list (read-from-minibuffer "Title: "
                                           (if (use-region-p)
                                               (buffer-substring (mark) (point))
                                             nil
                                             ))
                     ))
  (robenkleene/safe-find-file
   (shell-command-to-string (concat "~/.bin/inbox_new "
                                    (shell-quote-argument title))
                            ))
  )

(defun robenkleene/open-emacs-scratch ()
  "Switch to scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*")
  )

(defun robenkleene/open-emacs-messages ()
  "Switch to messages buffer."
  (interactive)
  (switch-to-buffer "*Messages*")
  )

(defun robenkleene/open-scratch-other-window ()
  "Switch to scratch for current buffer in other window."
  (interactive)
  (let ((file (robenkleene/scratch-for-file (buffer-file-name))))
    (if (bound-and-true-p file)
        (find-file-other-window file)
      (message "No file found.")
      )
    )
  )

(defun robenkleene/open-scratch-for-file ()
  "Switch to scratch file for current buffer."
  (interactive)
  (let ((file (robenkleene/scratch-for-file (buffer-file-name))))
    (if (bound-and-true-p file)
        (find-file file)
      (message "No file found.")
      )
    )
  )

(defun robenkleene/scratch-for-file (file)
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

(defun robenkleene/make-scratch-frame ()
  "Make a new frame and go to the scratch buffer."
  (interactive)
  (let ((frame (make-frame)))
    (select-frame-set-input-focus frame)
    (switch-to-buffer "*scratch*")))

(defun robenkleene/make-scratch-frame-with-current-frame ()
  "Make a new scratch frame the same size as the current frame."
  (interactive)
  (robenkleene/make-frame-with-current-frame)
  (switch-to-buffer "*scratch*")
  )

(defun robenkleene/make-frame-with-current-frame ()
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

(defun robenkleene/kill-buffer-file-name ()
  "Copy the filename to the kill ring."
  (interactive)
  (message (buffer-file-name))
  (kill-new (buffer-file-name))
  )

(defun robenkleene/kill-buffer-name ()
  "Kill `buffer-name'"
  (interactive)
  (message (buffer-name))
  (kill-new (buffer-name))
  )

(defun robenkleene/kill-default-directory ()
  "Kill `default-directory'."
  (interactive)
  (message default-directory)
  (kill-new default-directory))

(defun robenkleene/kill-date-today ()
  "Kill the today's date."
  (interactive)
  (message (robenkleene/today))
  (kill-new (robenkleene/today)))

(defun robenkleene/egit-update (&optional arg)
  "Run update."
  (interactive)
  (async-shell-command "~/.bin/egit_update" "*egit update*" "*egit update*")
  (switch-to-buffer-other-window "*egit update*")
  (view-mode)
  )

(defun robenkleene/toggle-grep-buffer ()
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

(provide 'robenkleene-functions-interactive)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-functions-interactive.el ends here
