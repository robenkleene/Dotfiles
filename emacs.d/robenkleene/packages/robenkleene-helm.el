;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package helm
  :commands (helm-semantic-or-imenu
             robenkleene/helm-ag-in-directory
             robenkleene/helm-recursive-find-file
             helm-find-files-or-marked
             helm-occur)
  :bind
  ;; ("M-A" . helm-do-grep-ag)
  ;; ("M-e" . robenkleene/helm-recursive-find-file)
  ;; ("M-c" . robenkleene/helm-recursive-find-dir)
  (:map robenkleene/leader-map
        ("H" . helm-resume)
        ;; ("A" . robenkleene/helm-ag-in-directory)
        ("I" . helm-semantic-or-imenu)
        ("E" . robenkleene/helm-recursive-find-file)
        ("C" . robenkleene/helm-recursive-find-dir)
        ("A" . robenkleene/helm-ag-in-directory)
        ("S" . helm-apropos)
        ("L" . helm-occur)
        ("B" . helm-buffer-list)
        )
  :init
  (setq helm-sources-using-default-as-input nil)
  (defun robenkleene/helm-ag-in-directory (dir)
    "Call `helm-do-grep-ag' in the current directory or with prefix specify a
directory."
    (interactive
     (list
      (if current-prefix-arg
          (read-directory-name "Base directory: ")
        default-directory)))
    ;; Clear the current prefix, for `helm-do-grep-ag' this just provides a list
    ;; of file types built-in to `rg` which is limiting.
    (let ((current-prefix-arg nil))
      (call-interactively 'helm-do-grep-ag)
      )
    )

  :config
  (setq helm-grep-use-ioccur-style-keys nil)
  (define-key helm-map (kbd "<left>") 'backward-char)
  (define-key helm-map (kbd "<right>") 'forward-char)
  ;; (define-key helm-grep-map (kbd "<left>") 'backward-char)
  ;; (define-key helm-grep-map (kbd "<right>") 'forward-char)
  (add-hook 'helm-grep-mode-hook (lambda()
                                   (define-key helm-grep-map (kbd "<left>") 'backward-char)
                                   (define-key helm-grep-map (kbd "<right>") 'forward-char)
                                   ))

  (require 'helm-files)
  (setq helm-grep-ag-command
        "rg --color=always --colors 'match:fg:white' --colors 'match:bg:cyan' --smart-case --no-heading --line-number %s %s %s")
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
                          "--color" "always"))
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
                          "--color" "always"))
     )
    (let ((current-prefix-arg nil))
      (helm-fd-1 dir)
      )
    )

  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
