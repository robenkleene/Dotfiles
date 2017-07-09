;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package helm
  :ensure t
  :defer t
  :init
  (use-package helm-ag
    :ensure t
    :defer t
    ;; :commands helm-do-ag
    :bind (:map robenkleene/relative-map
                ("a" . robenkleene/helm-do-ag)
                )
    :bind (:map robenkleene/leader-map
                ("a" . robenkleene/helm-do-ag)
                ("*" . robenkleene/helm-do-ag-best-available-selection)
                )
    :config
    (defun robenkleene/helm-do-ag (&optional arg)
      "Version of `helm-do-ag' that supports the universal argument."
      (interactive "P")
      (if (equal arg nil)
          (robenkleene/helm-do-ag-best-available)
        (helm-do-ag)
        )
      )
    (defun robenkleene/helm-do-ag-projectile-project-root ()
      "Run `helm-do-ag' from the `projectile-project-root'."
      (interactive)
      (use-package projectile)
      (if (boundp 'projectile-project-root)
          (helm-do-ag (projectile-project-root))
        (message "You're not in a project")
        )
      )
    (defun robenkleene/helm-do-ag-best-available (&optional targets)
      "Run `helm-do-ag' from the `projectile-project-root' if its available, otherwise from the `default-directory'."
      (interactive)
      (use-package projectile)
      (if (boundp 'projectile-project-root)
          (helm-do-ag (projectile-project-root) targets)
        (helm-do-ag default-directory targets)
        )
      )
    (defun robenkleene/helm-do-ag-best-available-selection (beg end)
      "Run `helm-do-ag-best-available' on the selection."
      (interactive (if (use-region-p)
                       (list (region-beginning) (region-end))
                     (list (point-min) (point-min))))
      (let ((selection (buffer-substring-no-properties beg end)))
        (if (= (length selection) 0)
            (robenkleene/helm-do-ag-best-available selection)
          (robenkleene/helm-do-ag-best-available))
        )
      )    

    ;; Enable grep mode after saving `helm-ag' results
    ;; To use: Trigger `C-x C-s' after performing a search to save the results
    ;; Then use `next-error' to cycle through matches
    (defadvice helm-ag--save-results
        (after robenkleene/helm-ag-grep-mode (args) activate)
      (with-current-buffer (get-buffer-create "*helm ag results*")
        (grep-mode)
        )
      )
    ;; Use `rg'
    (custom-set-variables
     '(helm-ag-base-command "rg --no-heading"))
    )

  (use-package helm-swoop
    :ensure t
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

  :config
  (setq helm-truncate-lines t)
  (setq helm-candidate-number-limit 1000)
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
