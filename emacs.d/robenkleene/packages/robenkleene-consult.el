;;; robenkleene-consult.el --- robenkleene-consult
;;; Commentary:
;;; Code:

(use-package consult
  :bind (
         ;; Use `consult-buffer' by default
         ;; Just use default `C-x b'
         ;; ("C-x b" . consult-buffer)
         ;; Just use default `C-x r'
         ;; ("C-x r" . consult-recent-file)
         ;; ("C-c q" . consult-compile-error)
         ("C-c g" . consult-ripgrep)
         ("C-c f" . rk/consult-fd)
         ;; Use `consult-line' by default which fuzzy matches lines, and jumps
         ;; to matches
         ("M-s o" . consult-line)
         ;; Use `consult-imenu' by default which automatically jumps to matches
         ("M-g i" . consult-imenu)
         )
  :commands
  (
   rk/consult-fd
   rk/consult-fd-pwd
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

  (defun rk/consult--fd-builder (input)
    (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                 (`(,re . ,hl) (funcall consult--regexp-compiler
                                        arg 'extended t)))
      (when re
        (cons (append
               (list "fd"
                     "--color=never"
                     "--hidden"
                     "--follow"
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
      (find-file (rk/consult--find prompt #'rk/consult--fd-builder initial))))

  (defun rk/consult-fd-pwd (&optional dir initial)
    "`consult-find' with `fd' in `pwd'."
    (interactive "P")
    (let ((default-directory (rk/pwd)))
      (call-interactively 'rk/consult-fd)
      ))

  )

;; Custom version of `consult--find' that just adds `:state
;; (consult--file-preview)' to enable file previews
(defun rk/consult--find (prompt builder initial)
  "Run find command in current directory.

The function returns the selected file.
The filename at point is added to the future history.

BUILDER is the command line builder function.
PROMPT is the prompt.
INITIAL is initial input."
  (consult--read
   (consult--async-command builder
     (consult--async-map (lambda (x) (string-remove-prefix "./" x)))
     (consult--async-highlight builder)
     :file-handler t) ;; allow tramp
   :prompt prompt
   :sort nil
   :require-match t
   :initial (consult--async-split-initial initial)
   :add-history (consult--async-split-thingatpt 'filename)
   :category 'file
   :state (consult--file-preview)
   :history '(:input consult--find-history)))

(provide 'robenkleene-consult)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-consult.el ends here
