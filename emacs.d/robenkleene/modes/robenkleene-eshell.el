;;; robenkleene-eshell.el --- robenkleene-eshell
;;; Commentary:
;;; Code:

;; Allow shell commands to be overridden in the `bin' directory
(with-eval-after-load 'esh-mode
  (add-to-list 'exec-path (expand-file-name (concat eshell-directory-name "bin")))
  )

(with-eval-after-load 'eshell
  ;; `less' can cause problems in `eshell'
  ;; Don't set `PAGER' to `cat', otherwise it will interfere with visual commands
  ;; that need a pager set
  (setenv "PAGER" "")
  ;; Instead just sety these as visual commands
  (setenv "GIT_PAGER" "")
  ;; Force `git' colors all the time
  ;; (setenv "GIT_CONFIG_PARAMETERS" "'color.ui=always'")

  ;; Enable `view-mode' bindings like `q' to quit when running visual commands
  ;; (which are already view-only)
  (defun rk/term-view-mode-once (&rest ignored)
    (view-mode 1)
    (remove-hook 'term-mode-hook #'rk/term-view-mode-once)
    )
  (defadvice eshell-exec-visual (before rk/eshell-exec-visual)
    "Wrapper function description."
    (add-hook 'term-mode-hook #'rk/term-view-mode-once)
    )

  ;; (defun eshell/git (&rest args)
  ;;   "Run git with color.ui auto when in Eshell."
  ;;   (let ((process-environment (cons "TERM=" process-environment)))
  ;;     (apply 'eshell-exec-visual (cons "git" args))))

  ;; (setq eshell-visual-options '(("git" "--help" "--paginate")))
  ;; (setq eshell-visual-subcommands '(("git" "log" "diff" "show")))

  (setq eshell-visual-subcommands '(
                                    ("hg" "diff" "show")
                                    ("git" "log" "diff" "show")
                                    )
        )

  ;; Show tab completion options instead of just choosing one
  ;; (setq eshell-cmpl-cycle-completions nil)

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

     ;; Bindings
     (define-key eshell-mode-map (kbd "C-u") 'eshell-kill-input)
     (define-key eshell-mode-map (kbd "C-c u") 'rk/eshell-kill-last-output)
     )
   )

  (defun rk/eshell-interactive-output-readonly ()
    "Make output of interactive commands in eshell read-only.
This should be the last entry in eshell-output-filter-functions!"
    (let ((end eshell-last-output-end))
      (save-excursion
        (goto-char end)
        (end-of-line 0)
        (setq end (point)))
      (when (< eshell-last-output-block-begin end)
        (put-text-property eshell-last-output-block-begin end 'read-only "Read-only interactive eshell output"))))

  (defun rk/eshell-make-interactive-output-readonly ()
    (add-hook 'eshell-output-filter-functions 'rk/eshell-interactive-output-readonly 'append))

  (add-hook 'eshell-mode-hook 'rk/eshell-make-interactive-output-readonly)

  (defun rk/eshell-kill-last-output ()
    "Kill the output."
    (interactive)
    (kill-ring-save (eshell-beginning-of-output) (eshell-end-of-output))
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

;; Kill the window after exiting `eshell' with `exit' (otherwise the window
;; stays with an open buffer in it)
(advice-add 'eshell-life-is-too-much :after (lambda () (when (not (one-window-p))
                                                         (delete-window))))

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

(provide 'robenkleene-eshell)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eshell.el ends here
