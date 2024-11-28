;;; robenkleene-remember.el --- robenkleene-remember
;;; Commentary:
;;; Code:

;; Don't add the current buffer file name to the file
(setq remember-annotation-functions nil)
(with-eval-after-load 'remember
  (define-key remember-mode-map (kbd "C-x C-s")
              (lambda ()
                (interactive)
                (message "Use `C-c C-c' to finalize or `C-c C-k' to cancel")))
  )

(provide 'robenkleene-remember)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-remember.el ends here
