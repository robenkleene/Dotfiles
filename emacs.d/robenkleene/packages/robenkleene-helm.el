;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package helm
  :commands (helm-semantic-or-imenu)
  :bind ("M-r" . helm-resume)
  :bind (:map robenkleene/emacs-lisp-leader-map
              ("i" . helm-semantic-or-imenu)
              )
  :bind (:map robenkleene/leader-map
              ("a" . helm-do-grep-ag)
              ("h" . helm-apropos)
              )
  :init

  (use-package helm-swoop
    :bind (:map robenkleene/leader-map
                ("l" . helm-swoop)
                )
    :init
    (custom-set-faces
     `(helm-swoop-target-word-face ((t (:foreground nil :background nil :bold nil :inherit isearch))))
     `(helm-swoop-target-line-face ((t (:foreground nil :background nil :inherit hl-line))))
     )
    :config
    ;; Don't use word at cursor by default
    (setq helm-swoop-pre-input-function (lambda () nil))
    )

  (setq helm-grep-ag-command "rg --color=always --colors 'match:fg:black' --colors 'match:bg:yellow' --smart-case --no-heading --line-number %s %s %s")

  (defun robenkleene/helm-documentation ()
    "`find-file' in documentation"
    (require 'helm-files)
    (interactive)
    (helm-find-1 "~/Documentation")
    )

  (defalias 'doc 'robenkleene/helm-documentation)

  (defun robenkleene/helm-tmux ()
    "Find file in the current Git repository."
    (interactive)
    (let ((cands (split-string
                  (shell-command-to-string "tmux-paths")
                  "\n"
                  t)))
      (find-file (helm-comp-read "Files:" cands))
      )
    )
  (defalias 'tmp 'robenkleene/helm-tmux)

  ;; Make `hgrep' a standard grep buffer
  (defadvice helm-grep-save-results-1
      (after robenkleene/helm-do-grep-ag-grep-mode () activate)
    (with-current-buffer (get-buffer-create "*hgrep*")
      (grep-mode)
      )
    )

  :config
  (setq helm-truncate-lines t)
  (setq helm-candidate-number-limit 1000)
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
