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

(defun robenkleene/external-editor ()
  "Open a region or buffer in external editor."
  (interactive)
  (if (use-region-p)
      (progn
        (shell-command-on-region (region-beginning) (region-end) "mate -a")
        (deactivate-mark)
        )
    (if (buffer-file-name)
        (shell-command (concat "mate -a "
                               (shell-quote-argument buffer-file-name))
                       )
      )
    )
  )



(defun robenkleene/ido-recursive-find-file (dir)
  "Find file recursively in DIR."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      default-directory)))
  (let ((current-prefix-arg nil) project-files key-to-path)
    (setq project-files
	  (split-string
	   (shell-command-to-string
	    (concat "fd "
		    " --type f --hidden --exclude .git --exclude .DS_Store"
		    dir
		    )) "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
	      (setq key (replace-regexp-in-string dir "" path))
	      (puthash key path key-to-path)
	      (push key ido-list))
	    project-files)
      (find-file (gethash (ido-completing-read "project-files: " ido-list) key-to-path)))
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

(defun robenkleene/highlight-keywords ()
  "Highlight keywords."
  (interactive)
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t)))
  )

(defvar robenkleene/scratch-directory-path "~/Development/Scratch/Source/")
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

(defvar robenkleene/documentation-directory-path "~/Documentation/development-references/Emacs/")
(defun robenkleene/emacs-documentation ()
  "Open Emacs documentation directory."
  (interactive)
  (find-file-other-window robenkleene/documentation-directory-path)
  )

(defvar robenkleene/org-directory-path "~/Development/Scratch/Org")
(defun robenkleene/emacs-org ()
  "Open Emacs documentation directory."
  (interactive)
  (find-file-other-window robenkleene/org-directory-path)
  )

(defun robenkleene/print-variable ()
  "Replace the current line with a variable print statement."
  (interactive)
  (let ((extension (file-name-extension (buffer-file-name))))
    (if extension
        (shell-command-on-region
         (line-beginning-position)
         (line-end-position)
         (format "variable-print -l %s" extension)
         nil
         t)
      )
    )
  )

(defun robenkleene/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (cdr (buffer-list (current-buffer)))
        )
  )
(defalias 'kill-other-buffers 'robenkleene/kill-other-buffers)

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

(defun robenkleene/rg-selection ()
  "Run `rg' on the selection.  BEG END."
  (interactive)
  (apply 'robenkleene/rg
         (robenkleene/grep-parameters (robenkleene/selection-or-word))
         )
  )

;; (defun robenkleene/rg-selection-in-directory (dir)
;;   "Call `rg' in the current directory or with prefix specify a directory."
;;   (interactive
;;    (list
;;     (if current-prefix-arg
;;         (read-directory-name "Base directory: ")
;;       default-directory)))
;;   (let ((current-prefix-arg nil))
;;     (apply 'robenkleene/rg
;;            (robenkleene/grep-parameters (robenkleene/selection-or-word)
;;                                         nil
;;                                         dir)
;;            )
;;     )
;;   )

(defcustom robenkleene/rg-command-files "rg --smart-case --no-heading --glob \"<F>\" <R> <D>"
  "Default `rg' command.")
(defcustom robenkleene/rg-command "rg --smart-case --no-heading <R> <D>"
  "Default `rg' command.")

(defun robenkleene/rg (regexp &optional files dir)
  "Search for the given REGEXP using `git grep' in the current directory.  FILES DIR."
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


(provide 'robenkleene-functions)
;;; robenkleene-functions.el ends here
