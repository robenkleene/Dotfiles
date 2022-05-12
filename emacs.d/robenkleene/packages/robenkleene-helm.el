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
             helm-find-files-or-marked
             helm-occur)
  :bind
  ;; ("M-A" . helm-do-g
  ("M-e" . robenkleene/helm-recursive-find-file)
  ;; ("M-o" . robenkleene/helm-recursive-find-file)
  ("M-c" . robenkleene/helm-recursive-find-dir)
  ("C-x b" . helm-buffers-list)
  (:map robenkleene/leader-map
        ("h" . helm-resume)
        ;; ("A" . robenkleene/helm-ag-in-directory)
        ("i" . helm-semantic-or-imenu)
        ;; ("E" . robenkleene/helm-recursive-find-file)
        ;; ("C" . robenkleene/helm-recursive-find-dir)
        ("O" . robenkleene/helm-recursive-find-file)
        ("a" . robenkleene/helm-ag-in-directory)
        ("H" . helm-apropos)
        ("l" . helm-occur)
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

  ;; (defun robenkleene/helm-fd-transformer (candidates _source)
  ;;   "A helm transformer to process fd result CANDIDATES."
  ;;   (let (non-essential
  ;;         (default-directory (helm-default-directory)))
  ;;     (cl-loop for i in candidates
  ;;              for abs = (helm-aif (file-remote-p default-directory)
  ;;                                  (concat it (file-relative-name i))
  ;;                                  (file-relative-name i))
  ;;              for type = (car (file-attributes abs))
  ;;              for disp = (if (and helm-ff-transformer-show-only-basename
  ;;                                  (not (string-match "[.]\\{1,2\\}$" i)))
  ;;                             (helm-basename abs) abs)
  ;;              collect (cond ((eq t type)
  ;;                             (cons (propertize disp 'face 'helm-ff-directory)
  ;;                                   abs))
  ;;                            ((stringp type)
  ;;                             (cons (propertize disp 'face 'helm-ff-symlink)
  ;;                                   abs))
  ;;                            (t (cons (propertize disp 'face 'helm-ff-file)
  ;;                                     abs))))))
  
  ;; (defun robenkleene/helm-fd--build-cmd-line ()
  ;;   "Build the fd command line from current `helm-pattern'."
  ;;   (let* ((default-directory (or (file-remote-p default-directory 'localname)
  ;;                                 default-directory))
  ;;          (patterns+options (split-string helm-pattern "\\(\\`\\| +\\)\\* +"))
  ;;          (patterns (split-string (car patterns+options)))
  ;;          (additional-options (and (cdr patterns+options)
  ;;                                   (list (concat (cadr
  ;;                                                  patterns+options) " ")))))
  ;;     (concat "fd"
  ;;             " --type f --follow --hidden --exclude .git --exclude .hg --exclude .DS_Store . "
  ;;             (shell-quote-argument (expand-file-name default-directory)) " "
  ;;             (string-join additional-options " "))))
  
  ;; (defun robenkleene/helm-fd-shell-command-fn ()
  ;;   "Run and supervise the fd subprocess."
  ;;   (let* (process-connection-type
  ;;          non-essential
  ;;          (cmd (robenkleene/helm-fd--build-cmd-line))
  ;;          (proc (start-file-process-shell-command "hfd" helm-buffer cmd)))
  ;;     (helm-log "fd command:\n%s" cmd)
  ;;     (prog1 proc
  ;;       (set-process-sentinel
  ;;        proc
  ;;        (lambda (process event)
  ;;          (helm-process-deferred-sentinel-hook
  ;;           process event (helm-default-directory))
  ;;          (if (string= event "finished\n")
  ;;              (with-helm-window
  ;;               (setq mode-line-format
  ;;                     '(" " mode-line-buffer-identification " "
  ;;                       (:eval (format "L%s" (helm-candidate-number-at-point)))
  ;;                       " "
  ;;                       (:eval (propertize
  ;;                               (format "[fd process finished - (%s results)]"
  ;;                                       (max (1- (count-lines
  ;;                                                 (point-min) (point-max)))
  ;;                                            0))
  ;;                               'face 'helm-locate-finish))))
  ;;               (force-mode-line-update))
  ;;            (helm-log "Error: fd %s"
  ;;                      (replace-regexp-in-string "\n" "" event))))))))
  
  ;; ;; (defvar robenkleene/helm-fd-map
  ;; ;;   (let ((map (make-sparse-keymap)))
  ;; ;;     (set-keymap-parent map helm-generic-files-map)
  ;; ;;     (define-key map (kbd "DEL") 'helm-delete-backward-no-update)
  ;; ;;     map))
  
  ;; (defvar robenkleene/helm-fd-source
  ;;   (helm-build-async-source "fd"
  ;;                            :header-name (lambda (name)
  ;;                                           (concat name " in [" (helm-default-directory) "]"))
  ;;                            :candidates-process 'robenkleene/helm-fd-shell-command-fn
  ;;                            :filtered-candidate-transformer 'robenkleene/helm-fd-transformer
  ;;                            :action-transformer 'helm-transform-file-load-el
  ;;                            :persistent-action 'helm-ff-kill-or-find-buffer-fname
  ;;                            :action 'helm-type-file-actions
  ;;                            :help-message 'helm-generic-file-help-message
  ;;                            ;; :keymap robenkleene/helm-fd-map
  ;;                            :candidate-number-limit 9999
  ;;                            :requires-pattern 3))
  
  ;; (defun robenkleene/helm-fd (dir)
  ;;   "Run `fd' in DIR."
  ;;   (let ((default-directory (file-name-as-directory dir)))
  ;;     (helm :sources 'robenkleene/helm-fd-source
  ;;           :buffer "*helm fd*"
  ;;           :ff-transformer-show-only-basename nil
  ;;           :case-fold-search helm-file-name-case-fold-search))
  ;;   )
  
  ;; (defun robenkleene/helm-clipboard-history-copy ()
  ;;   "Copy from clipboard history."
  ;;   (interactive)
  ;;   )

  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
