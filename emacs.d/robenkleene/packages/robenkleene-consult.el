;;; robenkleene-consult.el --- robenkleene-consult
;;; Commentary:
;;; Code:

(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :commands
  (robenkleene/consult-doc
   robenkleene/consult-z
   robenkleene/consult-fd
   robenkleene/consult-fd-pwd)
  :bind
  ;; Prefer the evil leader bindings
  ;; ("C-c l" . consult-line)
  (:map dired-mode-map
        ;; ("M-a" . consult-ripgrep)
        ("M-z" . robenkleene/consult-z)
        )

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config
  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))

  (defun robenkleene/consult-z ()
    "z using `completing-read'."
    (interactive)
    (find-file
     (consult--read
      (or (mapcar #'abbreviate-file-name
                  (split-string
                   (replace-regexp-in-string
                    "\n$" ""
                    (shell-command-to-string
                     "zoxide query --list"))
                   "\n"))
          (user-error "No recent files"))
      :prompt "Z: "
      :sort nil
      :require-match t
      :category 'file
      :state (consult--file-preview)
      :history 'file-name-history)))

  (defun robenkleene/consult-fd (&optional dir initial)
    "`consult-find with fd'."
    (interactive "P")
    (let ((consult-find-command "fd --type f --color=never --hidden --exclude .git/ --exclude .hg/ --exclude .DS_Store"))
      (consult-find dir initial)))

  (defun robenkleene/consult-fd-pwd (&optional dir initial)
    "`consult-find with fd'."
    (interactive "P")
    (let* (
           (default-directory (getenv "PWD"))
           (consult-find-command
            "fd --type f --color=never --hidden --exclude .git/ --exclude .hg/ --exclude .DS_Store")
           )
      (consult-find dir initial)))

  (defun robenkleene/consult-doc ()
    "Doc using `completing-read'."
    (interactive)
    (let ((default-directory "~/Documentation"))
      (find-file
       (consult--read
        (or (mapcar #'abbreviate-file-name
                    (split-string
                     (replace-regexp-in-string
                      "\n$" ""
                      (shell-command-to-string
                       "fd --follow"))
                     "\n"))
            (user-error "No recent files"))
        :prompt "Doc: "
        :sort nil
        :require-match t
        :category 'file
        :state (consult--file-preview)
        :history 'file-name-history))
      )
    )

  )

(provide 'robenkleene-consult)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-consult.el ends here
