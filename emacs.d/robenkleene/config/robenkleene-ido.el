;;; robenkleene-ido.el --- robenkleene-ido
;;; Commentary:
;;; Code:

;; Helpers for running some functions with `ido' disabled
(defun rk/ido-call-disabled (func &rest args)
  "Temporarily disable IDO and call function FUNC with arguments ARGS."
  (interactive)
  (let ((read-file-name-function #'read-file-name-default))
    (if (called-interactively-p 'any)
        (call-interactively func)
      (apply func args))))
(defun rk/ido-advice-disable (command)
  "Disable IDO when command COMMAND is called."
  (advice-add command :around #'rk/ido-call-disabled))
;; Disable `ido-everywhere' for `dired-create-directory' (auto-completing
;; filenames makes that function useless)
(rk/ido-advice-disable 'dired-create-directory)

;; Find
(defun rk/ido-recursive-find-file (dir)
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
    (find-file (rk/ido-recursive-get-file (shell-quote-argument dir)))
    )
  )

(defun rk/ido-recent-find-file ()
  "Find file recursively in DIR."
  (interactive)
  (setq key-to-path (make-hash-table :test 'equal))
  (let (ido-list)
    (mapc (lambda (path)
            (let ((key (rk/ido-key-for-path path (getenv "HOME"))))
              (puthash key path key-to-path)
              (push key ido-list)
              )
            )
          recentf-list)
    (rk/safe-find-file
     (gethash (ido-completing-read "Find recent: " ido-list)
              key-to-path))
    )
  )

(defun rk/ido-bookmark-jump ()
  "Jump to bookmark."
  (interactive)
  (bookmark-jump
   (bookmark-get-bookmark
    (ido-completing-read "Jump: " (bookmark-all-names)))))

(defun rk/ido-recursive-find-dir (dir)
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
    (find-file (rk/ido-recursive-get-dir dir))
    )
  )

(defun rk/ido-recursive-find-file-other-window (dir)
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
    (find-file-other-window (rk/ido-recursive-get-file dir))
    )
  )

(defun rk/ido-recursive-find-dir-other-window (dir)
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
    (find-file-other-window (rk/ido-recursive-get-dir dir))
    )
  )

;; Insert

(defun rk/ido-recursive-insert-dir (dir)
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
    (insert (rk/ido-recursive-get-dir dir))
    )
  )

(defun rk/ido-recursive-insert-file (dir)
  "Find and insert directory recursively in DIR."
  (interactive
   (list
    (if current-prefix-arg
        (read-directory-name "Base directory: ")
      (expand-file-name default-directory)
      )
    )
   )
  (let* ((current-prefix-arg nil)
         (result (file-relative-name (rk/ido-recursive-get-file
                                      (shell-quote-argument dir))
                                     default-directory)))
    ;; The `default-directory' means inserted file is always relative to the
    ;; current directory.
    (if (use-region-p)
        (delete-region (region-beginning) (region-end))
      )
    (insert result)
    )
  )


;; Z

(defun rk/ido-z ()
  "Find recent directory."
  (interactive)
  (let ((current-prefix-arg nil) project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string "~/.bin/z_list")
           "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (rk/ido-key-for-path path (getenv "HOME"))))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (rk/safe-find-file (gethash (ido-completing-read "Find z: " ido-list)
                                           key-to-path))
      )
    )
  )

(defun rk/ido-links ()
  "Open link."
  (interactive)
  (let ((current-prefix-arg nil))
    (setq links
          (split-string
           (shell-command-to-string
            "~/.bin/dump_text_links")
           "\n"))
    (setq key-to-link (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (link)
              (let ((key link))
                (puthash key link key-to-link)
                (push key ido-list)
                )
              )
            links)
      (let ((result (gethash
                     (ido-completing-read "Find link: " ido-list)
                     key-to-link)))
        (shell-command
         (concat "echo "
                 (shell-quote-argument result)
                 " | ~/.bin/filter_urls_open")
         )
        )
      )
    )
  )

;; Helper

(defun rk/ido-key-for-path (path strip)
  "Return a good key for ido based on PATH, remove STRIP."
  (let* (
         (short-path (replace-regexp-in-string strip "" path))
         (best-path (if short-path short-path path))
         (container-dir (file-name-directory best-path))
         (filename (file-name-nondirectory best-path))
         )
    (if container-dir
        (concat filename
                (rk/ido-container-directory-token container-dir))
      filename
      )
    )
  )

(defun rk/ido-container-directory-token (dir)
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

(defun rk/ido-recursive-get-file (dir &optional term)
  "Find directory recursively in DIR."
  (let (project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string
            (concat "fd "
                    "--max-results=1000 --type f --follow --hidden --exclude .git --exclude .hg --exclude .DS_Store "
                    (or term ".")
                    " "
                    dir
                    )) "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (rk/ido-key-for-path path dir)))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (gethash (ido-completing-read "Find file: " ido-list) key-to-path)
      )
    )
  )

(defun rk/ido-recursive-get-dir (dir &optional term)
  "Find file recursively in DIR."
  (let (project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string
            (concat "fd "
                    "--max-results=1000 --type d --follow --hidden --exclude .git --exclude .hg "
                    (or term ".")
                    " "
                    dir
                    )) "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (rk/ido-key-for-path path dir)))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (gethash (ido-completing-read "Find dir: " ido-list) key-to-path)
      )
    )
  )

(defun rk/ido-recursive-get-file-or-dir (dir &optional term)
  "Find file recursively in DIR."
  (let (project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string
            (concat "fd "
                    "--max-results=10000 --hidden --follow --exclude .git --exclude .hg "
                    (or term ".")
                    dir
                    )) "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (rk/ido-key-for-path path dir)))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (gethash (ido-completing-read "Find: " ido-list) key-to-path)
      )
    )
  )

(defun rk/ido-recursive-get-git-repo (dir)
  "Find file recursively in DIR."
  (let (project-files key-to-path)
    (setq project-files
          (split-string
           (shell-command-to-string
            (concat "find "
                    dir
                    " -type d -exec test -e '{}/.git' ';' -print -prune"
                    )) "\n"))
    (setq key-to-path (make-hash-table :test 'equal))
    (let (ido-list)
      (mapc (lambda (path)
              (let ((key (rk/ido-key-for-path path dir)))
                (puthash key path key-to-path)
                (push key ido-list)
                )
              )
            project-files)
      (gethash (ido-completing-read "Find dir: " ido-list) key-to-path)
      )
    )
  )

(defun rk/ido-project-open ()
  "Find file recursively from quick open directories."
  (interactive)
  (find-file (rk/ido-recursive-get-file
              "--type f --max-depth 2 ~/Text/Projects" "README.md"))
  )

(defun rk/ido-frequent-open-file-or-dir ()
  "Find file recursively from quick open directories."
  (interactive)
  (find-file (rk/ido-recursive-get-file-or-dir
              (concat
               "~/Text "
               "~/Documentation ")
              "\"^[^.]+\\$|.*\\.md\" "))
  )

(defun rk/ido-quick-developer ()
  "Find file recursively from quick open directories."
  (interactive)
  (find-file (rk/ido-recursive-get-git-repo
              "~/Developer"))
  )

(provide 'robenkleene-ido)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ido.el ends here
