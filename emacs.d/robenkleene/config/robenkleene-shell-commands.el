;;; robenkleene-shell-commands.el --- robenkleene-shell-commands
;;; Commentary:
;;; Code:

;; Show current directory when running shell command
(setq shell-command-prompt-show-cwd t)

;; Set `Shell Command Output' buffer to view only and detect file type
(define-advice shell-command-on-region (:after (&rest _) rk/shell-command-output)
  "Enable `view-mode' and detect file type in `*Shell Command Output*' buffer."
  (let ((buffer (get-buffer "*Shell Command Output*")))
    (when (buffer-live-p buffer)
      (with-current-buffer buffer
        (view-mode)
        (set-auto-mode)
        ))))

;; Path
;; `man' will sometimes fail with an error on macOS  if not using `gnused'
(when (eq system-type 'darwin)
  (let ((paths-to-prepend
         (list
          (concat
           (string-trim (shell-command-to-string "brew --prefix"))
           "/opt/gnu-sed/libexec/gnubin")
          )
         ))
    (setenv "PATH" (mapconcat
                    'identity
                    (append paths-to-prepend
                            (list (getenv "PATH")))
                    ":"))
    (dolist (path-to-prepend paths-to-prepend)
      (add-to-list 'exec-path path-to-prepend))
    )
  )

(provide 'robenkleene-shell-commands)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-shell-commands.el ends here
