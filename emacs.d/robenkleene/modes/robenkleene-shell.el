;;; robenkleene-shell.el --- robenkleene-shell
;;; Commentary:
;;; Code:

(with-eval-after-load 'shell
  (define-key shell-mode-map (kbd "q") 'quit-window)

  ;; (setq explicit-shell-file-name "/usr/local/bin/fish")
  ;; (setq shell-file-name "fish")
  (add-hook 'shell-mode-hook (lambda ()
                               (setq comint-process-echoes t)
                               ;; Disable whitespace
                               (face-remap-add-relative 'nobreak-space '(:background nil))
                               ;; (face-remap-add-relative 'trailing-whitespace '(:background nil))
                               ;; (setq nobreak-space 'override-nobreak-space)
                               (whitespace-mode 0)
                               ))
  )

(provide 'robenkleene-shell)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-shell.el ends here
