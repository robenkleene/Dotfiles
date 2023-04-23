;;; robenkleene-eshell.el --- robenkleene-eshell
;;; Commentary:
;;; Code:

(with-eval-after-load 'eshell

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
     (face-remap-add-relative 'trailing-whitespace '(:background nil))
     ;; (setq nobreak-space 'override-nobreak-space)
     (whitespace-mode 0)

     ;; Bindings
     (define-key eshell-mode-map (kbd "C-u") 'eshell-kill-input)
     )
   )
  )

(defun egit-save ()
  "`egit' save"
  (interactive)
  (if (= (call-process "~/.bin/egit" nil nil nil "-p") 0)
      (progn
        (shell-command-to-string "~/.bin/sgitt_auto")
        )
    (eshell/cd (shell-command-to-string "~/.bin/egit -n | tr -d '\n'"))
    )
  )

(provide 'robenkleene-eshell)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eshell.el ends here
