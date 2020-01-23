;;; robenkleene-ido.el --- robenkleene-ido
;;; Commentary:
;;; Code:

;; Helpers for running some functions with `ido' disabled
(defun robenkleene/ido-call-disabled (func &rest args)
  "Temporarily disable IDO and call function FUNC with arguments ARGS."
  (interactive)
  (let ((read-file-name-function #'read-file-name-default))
    (if (called-interactively-p 'any)
        (call-interactively func)
      (apply func args))))
(defun robenkleene/ido-advice-disable (command)
  "Disable IDO when command COMMAND is called."
  (advice-add command :around #'robenkleene/ido-call-disabled))
;; Disable `ido-everywhere' for `dired-create-directory' (auto-completing
;; filenames makes that function useless)
(robenkleene/ido-advice-disable 'dired-create-directory)

;; Find
(defun robenkleene/ido-recursive-find-file (dir)
  "Find file recursively in DIR."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      (expand-file-name default-directory)
      )
    )
   )
  (let ((current-prefix-arg nil))
    (find-file (robenkleene/ido-recursive-get-file dir))
    )
  )

(defun robenkleene/ido-recent-find-file ()
  "Find file recursively in DIR."
  (interactive)
  (setq key-to-path (make-hash-table :test 'equal))
  (let (ido-list)
    (mapc (lambda (path)
            (let ((key (robenkleene/ido-key-for-path path (getenv "HOME"))))
              (puthash key path key-to-path)
              (push key ido-list)
              )
            )
          recentf-list)
    (robenkleene/safe-find-file
     (gethash (ido-completing-read "Find recent: " ido-list)
              key-to-path))
    )
  )

(defun robenkleene/ido-bookmark-jump ()
  "Jump to bookmark."
  (interactive)
  (bookmark-jump
   (bookmark-get-bookmark
    (ido-completing-read "Jump: " (bookmark-all-names)))))

(defun robenkleene/ido-recursive-find-dir (dir)
  "Find directory recursively in DIR."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      (expand-file-name default-directory)
      )
    )
   )
  (let ((current-prefix-arg nil))
    (find-file (robenkleene/ido-recursive-get-dir dir))
    )
  )

(defun robenkleene/ido-recursive-find-file-other-window (dir)
  "Find file recursively in DIR in other window."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      (expand-file-name default-directory)
      )
    )
   )
  (let ((current-prefix-arg nil))
    (find-file-other-window (robenkleene/ido-recursive-get-file dir))
    )
  )

(defun robenkleene/ido-recursive-find-dir-other-window (dir)
  "Find directory recursively in DIR in other window."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      (expand-file-name default-directory)
      )
    )
   )
  (let ((current-prefix-arg nil))
    (find-file-other-window (robenkleene/ido-recursive-get-dir dir))
    )
  )

(defun robenkleene/ido-source-control-recursive-find-file ()
  "Find file recursively from source control root."
  (interactive)
  (find-file (robenkleene/ido-recursive-get-file
              (robenkleene/source-control-directory)))
  )

(defun robenkleene/ido-source-control-recursive-find-dir ()
  "Find directory recursively from source control root."
  (interactive)
  (find-file (robenkleene/ido-recursive-get-dir
              (robenkleene/source-control-directory)))
  )

;; Insert

(defun robenkleene/ido-recursive-insert-dir (dir)
  "Find and insert file recursively in DIR."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      (expand-file-name default-directory)
      )
    )
   )
  (let ((current-prefix-arg nil))
    (insert (robenkleene/ido-recursive-get-dir dir))
    )
  )

(defun robenkleene/ido-recursive-insert-file (dir)
  "Find and insert directory recursively in DIR."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      (expand-file-name default-directory)
      )
    )
   )
  (let ((current-prefix-arg nil))
    ;; The `default-directory' means inserted file is always relative to the
    ;; current directory.
    (insert (file-relative-name (robenkleene/ido-recursive-get-file dir)
                                default-directory))
    )
  )

(defun robenkleene/ido-source-control-recursive-insert-file ()
  "Find and insert file recursively from source control root."
  (interactive)
  (insert (file-relative-name (robenkleene/ido-recursive-get-file
                               (robenkleene/source-control-directory))
                              default-directory))
  )

(defun robenkleene/ido-source-control-recursive-insert-dir ()
  "Find and insert directory recursively from source control root."
  (interactive)
  (insert (file-relative-name (robenkleene/ido-recursive-get-dir
                               (robenkleene/source-control-directory))
                              default-directory))
  )

;; Z

(defun robenkleene/ido-z ()
  "Find recent directory."
  (interactive)
  (let ((current-prefix-arg nil) project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string "fasd -Rdl")
           "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (robenkleene/ido-key-for-path path (getenv "HOME"))))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (robenkleene/safe-find-file (gethash (ido-completing-read "Find z: " ido-list)
                                      key-to-path))
      )
    )
  )

;; Helper

(defun robenkleene/ido-key-for-path (path strip)
  "Return a good key for ido based on PATH, remove STRIP."
  (let* (
         (short-path (replace-regexp-in-string strip "" path))
         (best-path (if short-path short-path path))
         (container-dir (file-name-directory best-path))
         (filename (file-name-nondirectory best-path))
         )
    (if container-dir
        (concat filename
                (robenkleene/ido-container-directory-token container-dir))
      filename
      )
    )
  )

(defun robenkleene/ido-container-directory-token (dir)
  "Return an appropriate container directory token for DIR."
  (let ((directory-name (file-name-nondirectory
                         (directory-file-name
                          (file-name-directory dir)))))
    (if (string-blank-p directory-name)
        ""
      (concat "<"
              directory-name
              ">")
      )
    )
  )

(defun robenkleene/ido-recursive-get-file (dir)
  "Find directory recursively in DIR."
  (let (project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string
            (concat "fd "
                    " --type f --hidden --exclude .git --exclude .DS_Store . "
                    dir
                    )) "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (robenkleene/ido-key-for-path path dir)))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (gethash (ido-completing-read "Find file: " ido-list) key-to-path)
      )
    )
  )

(defun robenkleene/ido-recursive-get-dir (dir)
  "Find file recursively in DIR."
  (let (project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string
            (concat "fd "
                    " --type d --hidden --exclude .git . "
                    dir
                    )) "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (robenkleene/ido-key-for-path path dir)))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (gethash (ido-completing-read "Find dir: " ido-list) key-to-path)
      )
    )
  )

;; (robenkleene/ido-vertical-call
;;  (lambda ()
;;    (gethash (ido-completing-read "Find dir: " ido-list) key-to-path)
;;    )
;;  )
;; Couldn't
;; (defun robenkleene/ido-vertical-call (fun)
;;   "Call FUN with ido vertical and return result."
;;   (ido-vertical-mode 1)
;;   (with-demoted-errors (funcall fun))
;;   (ido-vertical-mode -1)
;;   )

(provide 'robenkleene-ido)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ido.el ends here
