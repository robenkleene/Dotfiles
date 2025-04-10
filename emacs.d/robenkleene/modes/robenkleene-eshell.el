;;; robenkleene-eshell.el --- robenkleene-eshell
;;; Commentary:
;;; Code:

;; Allow shell commands to be overridden in the `bin' directory
(with-eval-after-load 'esh-mode
  (add-to-list 'exec-path (expand-file-name (concat eshell-directory-name "bin")))
  )

(with-eval-after-load 'eshell
  ;; Most `git' commands should use `term-mode' and have colors by default
  ;; (e.g., `eshell-visual-commands'), but for commands that don't use a pager,
  ;; like `git status', forcing colors is useful.
  (setenv "GIT_CONFIG_PARAMETERS" "'color.ui=always'")

  ;; Suppress "Welcome to the Emacs shell" startup message
  (setq eshell-banner-message "")

  ;; Truncate path to 20 characters
  ;; This particularly helps with small width windows because eshell will move the
  ;; visible part of the window to make the prompt cursor visible which cuts off
  ;; the left side of output
  (setq eshell-prompt-function
        (lambda ()
          (concat
           (let* (
                  (path (abbreviate-file-name (eshell/pwd)))
                  (length (length path))
                  (max 20)
                  )
             (if (> length max)
                 (concat "..." (substring path (- length max)))
               path
               ))
           (if (= (user-uid) 0) " # " " $ "))))


  (add-hook
   'eshell-mode-hook
   (lambda ()
     ;; For some reason eshell input uses this face
     (face-remap-add-relative
      'markdown-inline-code-face '(:foreground "white"))
     ;; Disable whitespace
     (face-remap-add-relative 'nobreak-space '(:background nil))
     ;; (face-remap-add-relative 'trailing-whitespace '(:background nil))
     ;; (setq nobreak-space 'override-nobreak-space)
     (whitespace-mode 0)

     ;; The `less' pager causes problems in Eshell, this can be mediated by e.g.,
     ;; setting `(setenv "PAGER" "")' and `(setenv "GIT_PAGER" "")'
     ;; But it's better to just switch to `term-mode' for these
     ;; Any command that automatically uses a pager should be configured with:
     ;; - `eshell-visual-commands': For commands (e.g., `vi')
     ;; - `eshell-visual-subcommands': For subcommands (e.g., `git show')
     ;; - `eshell-visual-options': For flags (e.g., `git --help')
     ;; Commands
     (add-to-list 'eshell-visual-commands "n")
     (add-to-list 'eshell-visual-commands "nnn")
     ;; Subcommands
     (add-to-list 'eshell-visual-subcommands '("git" "log" "diff" "show"))
     (add-to-list 'eshell-visual-subcommands '("hg" "diff" "show"))
     ;; Options
     (add-to-list 'eshell-visual-options '("git" "--help" "--paginate"))
     )
   )

  (defun eshell/z (&rest args)
    "Jump to directory."
    (eshell/cd
     (shell-command-to-string
      (concat "zoxide query "
              (apply 'eshell-flatten-and-stringify args)
              " | tr -d '\\n'")
      )
     )
    )

  (add-hook 'eshell-directory-change-hook 'rk/z-add)
  )

(provide 'robenkleene-eshell)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eshell.el ends here
