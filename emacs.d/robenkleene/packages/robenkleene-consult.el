;;; robenkleene-consult.el --- robenkleene-consult
;;; Commentary:
;;; Code:

(use-package consult
  :bind (
         ("C-x b" . consult-buffer)
         ("C-c r" . consult-recent-file)
         ("C-c q" . consult-compile-error)
         ("C-c s" . consult-ripgrep)
         ("C-c z" . rk/consult-z)
         ;; ("M-z" . rk/consult-z)
         ("C-c f" . rk/consult-fd)
         ("C-c c" . rk/consult-z-subdir)
         ("C-c -" . rk/consult-z-parentdir)
         ("C-c l" . consult-line)
         ("C-c i" . consult-imenu)
         )
  :commands
  (rk/consult-doc
   rk/consult-z
   rk/consult-z-subdir
   rk/consult-z-parentdir
   rk/consult-fd
   rk/consult-fd-pwd
   rk/consult-eshell-z
   consult-imenu
   consult-compile-error
   consult-ripgrep
   consult-theme
   consult-completion-in-region
   )

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Allow two character search terms
  (setq consult-async-min-input 2)

  ;; Get initial results faster
  ;; (setq consult-async-refresh-delay 0.01)
  (setq consult-async-input-debounce 0.05)
  ;; (setq consult-async-input-throttle 0.01)

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  ;; (setq register-preview-delay 0.5
  ;;       register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  (with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "M-c") 'rk/consult-z-subdir)
    )

  ;; Use `consult' for Emacs `ex' (command line) completions, and eshell
  ;; This causes eshell to complete `./update.sh' to `update.sh' which of course
  ;; fails
  ;; This should also work for the minibuffer
  (setq completion-in-region-function
        (lambda (&rest args)
          (apply (if vertico-mode
                     #'consult-completion-in-region
                   #'completion--in-region)
                 args)))

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

  (defun rk/consult-z ()
    "z using `completing-read'."
    (interactive)
    (find-file
     (consult--read
      (or (mapcar #'abbreviate-file-name
                  (split-string
                   (replace-regexp-in-string
                    "\n$" ""
                    (shell-command-to-string
                     "~/.bin/z_list"))
                   "\n"))
          (user-error "No recent files"))
      :prompt "Z: "
      :sort nil
      :require-match t
      :category 'file
      :state (consult--file-preview)
      :history 'file-name-history)))

  (defun rk/consult-z-subdir ()
    "z subdir using `completing-read'."
    (interactive)
    (find-file
     (consult--read
      (or (mapcar #'abbreviate-file-name
                  (split-string
                   (replace-regexp-in-string
                    "\n$" ""
                    (shell-command-to-string
                     "~/.bin/z_list_subdir"))
                   "\n"))
          (user-error "No recent files"))
      :prompt "Z: "
      :sort nil
      :require-match t
      :category 'file
      :state (consult--file-preview)
      :history 'file-name-history)))

  (defun rk/consult-z-parentdir ()
    "z subdir using `completing-read'."
    (interactive)
    (find-file
     (consult--read
      (or (mapcar #'abbreviate-file-name
                  (split-string
                   (replace-regexp-in-string
                    "\n$" ""
                    (shell-command-to-string
                     "~/.bin/z_list_parentdir"))
                   "\n"))
          (user-error "No recent files"))
      :prompt "Z: "
      :sort nil
      :require-match t
      :category 'file
      :state (consult--file-preview)
      :history 'file-name-history)))

  (defun rk/consult-eshell-z ()
    "z using `completing-read'."
    (interactive)
    (eshell/cd
     (consult--read
      (or (mapcar #'abbreviate-file-name
                  (split-string
                   (replace-regexp-in-string
                    "\n$" ""
                    (shell-command-to-string
                     "~/.bin/z_list"))
                   "\n"))
          (user-error "No recent files"))
      :prompt "Z: "
      :sort nil
      :require-match t
      :category 'file
      :state (consult--file-preview)
      :history 'file-name-history))
    (eshell-send-input)
    )

  (defun rk/consult--fd-builder (input)
    (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                 (`(,re . ,hl) (funcall consult--regexp-compiler
                                        arg 'extended t)))
      (when re
        (cons (append
               (list "fd"
                     "--type"
                     "f"
                     "--color=never"
                     "--hidden"
                     "--exclude"
                     ".git/"
                     "--exclude"
                     ".hg/"
                     "--exclude"
                     ".DS_Store"
                     (consult--join-regexps re 'extended))
               opts)
              hl))))

  (defun rk/consult-fd (&optional dir initial)
    (interactive "P")
    (pcase-let* ((`(,prompt ,paths ,dir) (consult--directory-prompt "Fd" dir)))
      (find-file (consult--find prompt #'rk/consult--fd-builder initial))))

  (defun rk/consult-fd-pwd (&optional dir initial)
    "`consult-find' with `fd' in `pwd'."
    (interactive "P")
    (let ((default-directory (rk/pwd)))
      (call-interactively 'rk/consult-fd)
      ))

  (defun rk/consult-doc ()
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
