;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package helm
  :commands (helm-semantic-or-imenu helm-do-grep-ag)
  :bind (:map robenkleene/emacs-lisp-leader-map
              ("i" . helm-semantic-or-imenu)
              )
  :bind (:map robenkleene/leader-map
              ("h" . helm-resume)
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
  
  (defun robenkleene/helm-documentation ()
    "`find-file' in documentation"
    (interactive)
    (require 'helm-files)
    (helm-find-1 "~/Documentation")
    )
  (defalias 'doc 'robenkleene/helm-documentation)

  :config
  (setq helm-grep-ag-command "rg --color=always --colors 'match:fg:white' --colors 'match:bg:cyan' --colors 'path:fg:cyan' --colors 'line:fg:white' --smart-case --no-heading --line-number %s %s %s")
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
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
