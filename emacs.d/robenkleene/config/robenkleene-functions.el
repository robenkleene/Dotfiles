;;; robenkleene-functions.el --- robenkleene-functions
;;; Commentary:
;;; Code:

(defun robenkleene/system-is-mac ()
  "Test if this is a Mac."
  (string-equal system-type "darwin"))

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

(defun robenkleene/buffer-backed-by-file-p (buffer)
  "Return non-nil if the BUFFER is backed by a file."
  (let ((backing-file (buffer-file-name buffer)))
    (if (buffer-modified-p buffer)
        t
      (if backing-file
          (file-exists-p (buffer-file-name buffer))
        t))))

(defun robenkleene/highlight-keywords ()
  "Highlight keywords."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t)))
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

(defun robenkleene/safe-find-file (file)
  "Only open a FILE if it exists."
  (when (file-readable-p file)
    (find-file file))
  )

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

(defun robenkleene/date-today (&optional arg)
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
