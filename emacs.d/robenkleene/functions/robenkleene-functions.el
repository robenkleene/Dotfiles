;;; robenkleene-functions.el --- robenkleene-functions
;;; Commentary:
;;; Code:

(defun rk/system-is-mac ()
  "Test if this is a Mac."
  (string-equal system-type "darwin"))

(defun rk/highlight-keywords ()
  "Highlight keywords."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t)))
  )

(defun rk/grep-parameters (&optional regexp files dir)
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

(defvar rk/rg-command)
(setq rk/rg-command
      "rg --color=always --colors 'match:fg:white' --colors 'match:bg:cyan' --smart-case --no-heading --line-number <R> <D>")

(defun rk/safe-find-file (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file file))
  )

(defun rk/safe-find-file-other-window (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file-other-window file))
  )

(defun rk/project-override (dir)
  "Override project function with DIR."
  (let ((override (locate-dominating-file dir ".project")))
    (if override
        (cons 'vc override)
      nil)))

(defun rk/date-today (&optional arg)
  "Return the current date."
  (shell-command-to-string "date +%Y-%m-%d | tr -d '\n'")
  )

(provide 'robenkleene-functions)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-functions.el ends here
