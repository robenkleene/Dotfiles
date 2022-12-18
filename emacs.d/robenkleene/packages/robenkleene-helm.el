;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package helm
  :commands (helm-semantic-or-imenu
             helm-buffers-list
             robenkleene/helm-ag-in-directory
             robenkleene/helm-recursive-find-file
             robenkleene/helm-documentation-edit
             robenkleene/helm-text-edit
             robenkleene/helm-z
             helm-find-files-or-marked
             helm-occur
             )
  :bind
  ("C-c l" . helm-occur)
  ("C-x b" . helm-buffer-list)
  ;; (:map robenkleene/window-map
  ;;       ("a" . robenkleene/helm-ag-in-directory)
  ;;       )
  (:map dired-mode-map
        ("M-a" . robenkleene/helm-ag-in-directory)
        ("M-o" . robenkleene/helm-recursive-find-file)
        ("M-e" . robenkleene/helm-recursive-find-file)
        ("M-c" . robenkleene/helm-recursive-find-dir)
        ("M-z" . robenkleene/helm-z)
        )
  :init
  (defun o ()
    "Alias."
    (interactive)
    (call-interactively 'robenkleene/helm-recursive-find-file)
    )
  (defun e ()
    "Alias."
    (interactive)
    (call-interactively 'robenkleene/helm-recursive-find-file)
    )
  (defun c ()
    "Alias."
    (interactive)
    (call-interactively robenkleene/helm-recursive-find-dir)
    )
  (defun z ()
    "Alias."
    (interactive)
    (call-interactively 'robenkleene/helm-z)
    )
  (defun a ()
    "Alias."
    (interactive)
    (call-interactively 'robenkleene/helm-ag-in-directory)
    )
  (setq helm-sources-using-default-as-input nil)

  ;; Only the named colors work here for some reason, e.g., we're using
  ;; `magenta' instead of `91', which is the exact color we want
  (setq helm-grep-ag-command
        "rg --color=always --colors 'match:fg:white' --colors 'match:bg:magenta' --smart-case --no-heading --line-number %s %s %s")
  (defun robenkleene/helm-ag-in-directory ()
    "Call `helm-do-grep-ag' in the current directory or with prefix specify a
directory."
    (interactive)
    ;; Clear the current prefix, for `helm-do-grep-ag' this just provides a list
    ;; of file types built-in to `rg` which is limiting.
    (let ((helm-grep-ag-command (if current-prefix-arg
                                    (concat helm-grep-ag-command
                                            " --max-depth 1")
                                  helm-grep-ag-command))
          (current-prefix-arg nil)
          )
      (call-interactively 'helm-do-grep-ag)
      )
    )

  :config
  (setq helm-grep-use-ioccur-style-keys nil)
  (define-key helm-map (kbd "<left>") 'backward-char)
  (define-key helm-map (kbd "<right>") 'forward-char)
  ;; (define-key helm-grep-map (kbd "<left>") 'backward-char)
  ;; (define-key helm-grep-map (kbd "<right>") 'forward-char)
  (add-hook 'helm-grep-mode-hook
            (lambda()
              (define-key helm-grep-map (kbd "<left>") 'backward-char)
              (define-key helm-grep-map (kbd "<right>") 'forward-char)
              ))

  (require 'helm-files)
  ;; Use relative paths (this makes `wgrep' possible)
  (setq helm-grep-file-path-style 'relative)
  (setq helm-truncate-lines t)
  (setq helm-candidate-number-limit 1000)
  ;; Make `hgrep' a standard grep buffer
  (defadvice helm-grep-save-results-1
      (after robenkleene/helm-do-grep-ag-grep-mode () activate)
    (with-current-buffer (get-buffer-create "*hgrep*")
      (grep-mode)
      )
    )
  (defadvice helm-occur-save-results
      (after helm-occur () activate)
    (with-current-buffer (get-buffer-create "*hmoccur*")
      (grep-mode)
      )
    )

  (require 'helm-fd)
  (defun robenkleene/helm-recursive-find-file (dir)
    "Find file recursively in DIR."
    (interactive
     (list
      (if current-prefix-arg
          (read-directory-name "Base directory: ")
        (expand-file-name default-directory)
        )
      )
     )
    (custom-set-variables
     '(helm-fd-switches '("--type" "f" "--follow" "--hidden" "--exclude"
                          ".git" "--exclude" ".hg" "--exclude" ".DS_Store"
                          "--color" "never"))
     )
    (let ((current-prefix-arg nil))
      (helm-fd-1 dir)
      )
    )

  (defun robenkleene/helm-recursive-find-dir (dir)
    "Find dir recursively in DIR."
    (interactive
     (list
      (if current-prefix-arg
          (read-directory-name "Base directory: ")
        (expand-file-name default-directory)
        )
      )
     )
    (custom-set-variables
     '(helm-fd-switches '("--type" "d" "--follow" "--hidden" "--exclude"
                          ".git" "--exclude" ".hg" "--exclude" ".DS_Store"
                          "--color" "never"))
     )
    (let ((current-prefix-arg nil))
      (helm-fd-1 dir)
      )
    )

  (defun robenkleene/helm-recursive-find-file-or-dir (dir)
    "Find file recursively in DIR."
    (interactive
     (list
      (if current-prefix-arg
          (read-directory-name "Base directory: ")
        (expand-file-name default-directory)
        )
      )
     )
    (custom-set-variables
     '(helm-fd-switches '("--follow" "--hidden" "--exclude"
                          ".git" "--exclude" ".hg" "--exclude" ".DS_Store"
                          "--color" "never"))
     )
    (let ((current-prefix-arg nil))
      (helm-fd-1 dir)
      )
    )

  (defun robenkleene/helm-documentation-edit ()
    "Edit documentation."
    (interactive)
    (robenkleene/helm-recursive-find-file-or-dir "~/Documentation/")
    )

  (defun robenkleene/helm-text-edit ()
    "Edit documentation."
    (interactive)
    (robenkleene/helm-recursive-find-file-or-dir "~/Documents/Text/Notes")
    )

  (defun robenkleene/helm-z ()
    "helm z."
    (interactive)
    (find-file (helm-comp-read
                "Z: "
                (split-string
                 (shell-command-to-string
                  "zoxide query --list | sort | sed 's/\\/$//' | uniq")
                 "\n"
                 t)))
    )

  )

(provide 'robenkleene-helm)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-helm.el ends here
