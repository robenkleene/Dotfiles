;;; robenkleene-bash.el --- robenkleene-bash
;;; Commentary:
;;; Code:

(add-hook 'sh-mode-hook
          (lambda ()
            (when (boundp 'whitespace-style)
              (whitespace-mode 0)
              (setq-local whitespace-style (push 'lines-tail
                                                 whitespace-style))
              (whitespace-mode 1)
              )
            )
          )

(provide 'robenkleene-bash)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-bash.el ends here
