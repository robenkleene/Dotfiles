;;; robenkleene-shell-commands.el --- robenkleene-shell-commands
;;; Commentary:
;;; Code:

;; Set `Shell Command Output' buffer to view only and detect file type
(define-advice shell-command-on-region (:after (&rest _) rk/shell-command-output)
  "Enable `view-mode' and detect file type in `*Shell Command Output*' buffer."
  (let ((buffer (get-buffer "*Shell Command Output*")))
    (when (buffer-live-p buffer)
      (with-current-buffer buffer
        (view-mode)
        (set-auto-mode)
        ))))

(provide 'robenkleene-shell-commands)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-shell-commands.el ends here
