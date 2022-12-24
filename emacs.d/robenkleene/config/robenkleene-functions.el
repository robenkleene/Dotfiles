;;; robenkleene-functions.el --- robenkleene-functions
;;; Commentary:
;;; Code:

(defun robenkleene/edit-init ()
  "Edit init."
  (interactive)
  (find-file "~/.emacs.d/robenkleene/robenkleene.el")
  )

(defun robenkleene/system-is-mac ()
  "Test if this is a Mac."
  (string-equal system-type "darwin"))

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

(defun robenkleene/kill-region-or-backward-word ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, call `backward-kill-word'."
  (interactive)
  (call-interactively
   (if (use-region-p) 'kill-region 'backward-kill-word)))

(defun robenkleene/empty-frame ()
  "Open a new frame with a buffer named Untitled."
  (interactive)
  (switch-to-buffer-other-frame (robenkleene/new-empty-buffer))
  )

(defun robenkleene/new-empty-buffer ()
  "Return a new empty buffer."
  (let*
      ;; Set the `default-directory' so that's where autosaves will go
      ((default-directory (concat user-emacs-directory "untitled"))
       (buffer (generate-new-buffer "untitled"))
       )
    (set-buffer buffer)
    (text-mode)
    (auto-save-mode)
    buffer
    )
  )

(defun robenkleene/new-empty ()
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

(defun robenkleene/new-empty-other-window ()
  "Open a new window with a buffer named Untitled."
  (interactive)
  (switch-to-buffer-other-window (robenkleene/new-empty-buffer))
  )

(defun robenkleene/new-empty-other-window-vertical ()
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

(defun robenkleene/slug-project (title dir)
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

(defun robenkleene/wiki-link ()
  "Make a wiki link from a file named after the region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/markdown_wiki_link"
                               nil
                               t)
    )
  )

(defun robenkleene/blog-link-with-file ()
  "Make a blog link from the current file."
  (interactive)
  (if (buffer-file-name)
      (robenkleene/safe-find-file
       (shell-command-to-string (concat "~/.bin/jekyll_new_draft -l -f "
                                        (shell-quote-argument buffer-file-name))
                                )
       )
    )
  )

(defun robenkleene/blog-post-with-file ()
  "Make a blog post from the current file."
  (interactive)
  (if (buffer-file-name)
      (robenkleene/safe-find-file
       (shell-command-to-string (concat "~/.bin/jekyll_new_draft -f "
                                        (shell-quote-argument buffer-file-name))
                                )
       )
    )
  )

(defun robenkleene/blog-publish-drafts ()
  "Commit everything in the current repository."
  (interactive)
  (shell-command "~/.bin/blog_publish_drafts")
  (robenkleene/kill-removed-buffers)
  )

(defun robenkleene/buffer-backed-by-file-p (buffer)
  "Return non-nil if the BUFFER is backed by a file."
  (let ((backing-file (buffer-file-name buffer)))
    (if (buffer-modified-p buffer)
        t
      (if backing-file
          (file-exists-p (buffer-file-name buffer))
        t))))

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

(defun robenkleene/archive-current-file ()
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

(defun robenkleene/archive ()
  "Archive region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/backup_text -m")
    )
  )

(defun robenkleene/todos-uncheck ()
  "Uncheck Markdown todos."
  (interactive)
  (robenkleene/shell-command-on-buffer-or-region "~/.bin/markdown_check -u -b")
  )

(defun robenkleene/todos-check ()
  "Check Markdown todos."
  (interactive)
  (robenkleene/shell-command-on-buffer-or-region "~/.bin/markdown_check -c -b")
  )

(defun robenkleene/todos-invert ()
  "Invert Markdown todos."
  (interactive)
  (robenkleene/shell-command-on-buffer-or-region "~/.bin/markdown_check -i -b")
  )

(defun robenkleene/title-case ()
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

(defun robenkleene/urls-open ()
  "Open URLs in the region."
  (interactive)
  (if (use-region-p)
      (shell-command-on-region (region-beginning)
                               (region-end)
                               "~/.bin/urls_open")
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
  (if (daemonp)
      (let ((client (frame-parameter nil 'client)))
        (find-file (set-frame-parameter nil
                                        'cwd
                                        (process-get client 'server-client-directory))))
    (find-file (getenv "PWD"))
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

(defun robenkleene/highlight-keywords ()
  "Highlight keywords."
  (interactive)
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t)))
  )

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

(defun robenkleene/documentation-file ()
  "Choose a documentation file."
  (robenkleene/ido-recursive-get-file
   robenkleene/documentation-directory-path))

(defun robenkleene/documentation-file-or-dir ()
  "Choose a documentation file."
  (robenkleene/ido-recursive-get-file-or-dir
   robenkleene/documentation-directory-path "\"^[^.]+\\$|.*\\.md\" "))

(defun robenkleene/bounds-of-selection-or-word ()
  "Get the bounds of the selection or word."
  (if (use-region-p)
      (list (region-beginning) (region-end))
    (let ((bounds (bounds-of-thing-at-point 'word)) )
      (list (car bounds) (cdr bounds))
      )
    )
  )

(defun robenkleene/selection-or-word ()
  "My function description."
  (let ((selection (apply 'buffer-substring-no-properties
                          (robenkleene/bounds-of-selection-or-word))))
    (if (= (length selection) 0) nil selection))
  )

(defun robenkleene/source-control-open-web (&optional arg)
  "Open the source control website for the current repository with ARG."
  (interactive)
  (shell-command (concat "~/.bin/source_control_open_site "
                         arg)
                 )
  )

(defun robenkleene/grep-parameters (&optional regexp files dir)
  "Get the parameters for grep.  REGEXP FILES DIR."
  (require 'grep)
  (if (equal current-prefix-arg nil)
      (list (or regexp (grep-read-regexp))
            files
            dir)
    ;; `grep-files-aliases' defaults to a version of `all' that's
    ;; incompatible with `rg'
    (let* ((grep-files-aliases '(("all" . "*.*")))
           (final-regexp (or regexp (grep-read-regexp)))
           (final-files (or files (grep-read-files final-regexp)))
           (final-dir (or dir
                          (read-directory-name "Base directory: "
                                               nil
                                               default-directory
                                               t)
                          )
                      )
           )
      (list final-regexp final-files final-dir)
      )
    )
  )

(defvar robenkleene/rg-command)
(setq robenkleene/rg-command
      "rg --color=always --colors 'match:fg:white' --colors 'match:bg:cyan' --smart-case --no-heading --line-number <R> <D>")

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

(defun robenkleene/compilation-next-once (buffer desc)
  "Run once after compilation."
  (robenkleene/next)
  (remove-hook 'compilation-finish-functions 'robenkleene/compilation-next-once)
  )

;; This doesn't work for some reason
;; (defun robenkleene/compilation-hide-once (buffer desc)
;;   "Hide next compilation."
;;   (let ((win (get-buffer-window buffer 'visible)))
;;     (when win (delete-window win)))
;;   (remove-hook 'compilation-finish-functions 'robenkleene/compilation-hide-once)
;;   )

(defun robenkleene/grep-from-clipboard ()
  "Grep buffer with clipboard."
  (interactive)
  (require 'grep)
  (add-hook 'compilation-finish-functions 'robenkleene/compilation-next-once)
  ;; (add-hook 'compilation-finish-functions 'robenkleene/compilation-hide-once)
  (compilation-start "safepaste" 'grep-mode)
  )

(defun robenkleene/git-diff-grep ()
  "Search for REGEXP with optional FILES and DIR."
  (interactive)
  (require 'grep)
  (cd (robenkleene/source-control-directory))
  (compilation-start
   "git diff --relative | diff_to_grep"
   'grep-mode)
  )

(defun robenkleene/hg-diff-grep ()
  "Search for REGEXP with optional FILES and DIR."
  (interactive)
  (require 'grep)
  (compilation-start
   "hg diff --root . | diff_to_grep"
   'grep-mode)
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
    (robenkleene/open-inbox)
    )
  )

(defun robenkleene/inbox-open ()
  "Switch to inbox directory."
  (interactive)
  (find-file "~/Documents/Text/Notes/Inbox/")
  )

(defun robenkleene/archive-open ()
  "Switch to inbox directory."
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

(defun robenkleene/safe-find-file (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file file))
  )

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

(defun robenkleene/kill-today ()
  "Kill the today's date."
  (interactive)
  (message (robenkleene/today))
  (kill-new (robenkleene/today)))

;;; describe this point lisp only
(defun robenkleene/describe-thing-at-point ()
  "Show the documentation of the Elisp function and variable near point.
    This checks in turn:
    -- for a function name where point is
    -- for a variable name where point is
    -- for a surrounding function call"
  (interactive)
  (let (sym)
    ;; sigh, function-at-point is too clever.  we want only the first half.
    (cond ((setq sym (ignore-errors
                       (with-syntax-table emacs-lisp-mode-syntax-table
                         (save-excursion
                           (or (not (zerop (skip-syntax-backward "_w")))
                               (eq (char-syntax (char-after (point))) ?w)
                               (eq (char-syntax (char-after (point))) ?_)
                               (forward-sexp -1))
                           (skip-chars-forward "`'")
                           (let ((obj (read (current-buffer))))
                             (and (symbolp obj) (fboundp obj) obj))))))
           (describe-function sym))
          ((setq sym (variable-at-point)) (describe-variable sym))
          ;; now let it operate fully -- i.e. also check the
          ;; surrounding sexp for a function call.
          ((setq sym (function-at-point)) (describe-function sym)))))

(defun robenkleene/save-buffer-if-visiting-file (&optional args)
  "Save the current buffer only if it is visiting a file"
  (interactive)
  (if (and (buffer-file-name) (buffer-modified-p))
      (progn
        (call-interactively #'save-buffer)
        )
    ))

(defun robenkleene/z-add ()
  "Add file or directory."
  (if (executable-find "zoxide")
      (let ((file (if (string= major-mode "dired-mode")
                      dired-directory
                    (buffer-file-name))))
        (when (and file
                   (stringp file)
                   (file-readable-p file))
          (start-process "*z add*" nil "zoxide" "add" "--" (expand-file-name file))))))

(defun robenkleene/project-override (dir)
  "Override project function with DIR."
  (let ((override (locate-dominating-file dir ".project")))
    (if override
        (cons 'vc override)
      nil)))

(defun robenkleene/today (&optional arg)
  "Return the current date."
  (interactive)
  (shell-command-to-string "date +%Y-%m-%d | tr -d '\n'")
  )

(defun robenkleene/describe-char-at-mouse-click (click-event)
  "`describe-char' at CLICK-EVENT's position.
CLICK-EVENT should be a mouse-click event."
  (interactive "e")
  (run-hooks 'mouse-leave-buffer-hook)
  (let ((pos (cadr (event-start click-event))))
    (describe-char pos)))

(provide 'robenkleene-functions)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-functions.el ends here
