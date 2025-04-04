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

  (setq eshell-visual-subcommands '(
                                    ("hg" "diff" "show")
                                    ("git" "log" "diff" "show")
                                    )
        )

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
