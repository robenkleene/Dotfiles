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

;; Then just make a `projectile' function that calls this?

(defun robenkleene/rg-selection (&optional arg beg end)
  "Run `rg' on the selection."
  (interactive (if (use-region-p)
                   (list current-prefix-arg (region-beginning) (region-end))
                 (let ((bounds (bounds-of-thing-at-point 'word)) )
                   (list current-prefix-arg (car bounds) (cdr bounds))
                   )
                 )
               )
  (let ((selection (buffer-substring-no-properties beg end)))
    (if (= (length selection) 0)
        (robenkleene/rg)
      (robenkleene/rg selection)
      )
    )
  )

(defcustom robenkleene/rg-command "rg --smart-case --vimgrep --no-heading <C> --glob <F> <R> <D>"
  "Default `rg' command.")
(require 'grep)
(defun robenkleene/rg (regexp &optional files dir)
  "Search for the given regexp using `git grep' in the current directory."
  (interactive (if (equal current-prefix-arg nil)
                   (list (grep-read-regexp) nil nil)
                 (let* ((regexp (grep-read-regexp))
                        (files (grep-read-files regexp))
                        (dir (read-directory-name "Base directory: "
                                                  nil
                                                  default-directory
                                                  t)
                             )
                        )
                   (list regexp files dir)
                   )
                 )
               )
  (let ((command (grep-expand-template
                  robenkleene/rg-command
                  regexp
                  (or files "*")
                  nil
                  (and grep-find-ignored-files
                       (concat " --exclude="
                               (mapconcat
                                #'(lambda (ignore)
                                    (cond ((stringp ignore)
                                           (shell-quote-argument ignore))
                                          ((consp ignore)
                                           (and (funcall (car ignore) dir)
                                                (shell-quote-argument
                                                 (cdr ignore))))))
                                grep-find-ignored-files
                                " --exclude="))))))
    (compilation-start command 'grep-mode)
    )
  )




(defalias 'rg 'robenkleene/rg)

(provide 'robenkleene-functions)
;;; robenkleene-functions.el ends here
