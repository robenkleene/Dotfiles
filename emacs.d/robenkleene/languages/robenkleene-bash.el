;;; robenkleene-bash.el --- robenkleene-bash
;;; Commentary:
;;; Code:

(add-hook 'sh-mode-hook
          (lambda ()
            (when (boundp 'whitespace-style)
              (setq-local whitespace-style (add-to-list 'lines-tail
                                                        whitespace-style)))
            ))

(provide 'robenkleene-bash)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-bash.el ends here
