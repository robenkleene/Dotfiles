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
             robenkleene/helm-clipboard-history-copy
             helm-find-files-or-marked
             helm-occur)
  :bind
  ;; ("M-A" . helm-do-g
  ("M-e" . robenkleene/helm-recursive-find-file)
  ;; ("M-o" . robenkleene/helm-recursive-find-file)
  ;; ("M-c" . robenkleene/helm-recursive-find-dir)
  ("C-x b" . helm-buffers-list)
  (:map robenkleene/leader-map
        ("h" . helm-resume)
        ;; ("A" . robenkleene/helm-ag-in-directory)
        ("i" . helm-semantic-or-imenu)
        ("C" . robenkleene/helm-recursive-find-dir)
        ("O" . robenkleene/helm-recursive-find-file)
        ("a" . robenkleene/helm-ag-in-directory)
        ("H" . helm-apropos)
        ("l" . helm-occur)
        ("\\" . robenkleene/helm-clipboard-history-copy)
        ;; ("b" . helm-buffers-list)
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
                          "--color" "always"))
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

  (defvar robenkleene/helm-clipboard-history-source
    (helm-build-async-source
        "helm clipboard history"
      :candidates-process
      (lambda ()
        (start-process
         "clipboard history"
         nil
         "clipboard_history_search"
         helm-pattern
         ))))

  (defun robenkleene/helm-clipboard-history-copy ()
    (interactive)
    (helm :sources robenkleene/helm-clipboard-history-source
          :buffer "*helm clipboard history*"
          :action '(lambda (candidate)
                     (message "candidate = %s." candidate)))
    )
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
