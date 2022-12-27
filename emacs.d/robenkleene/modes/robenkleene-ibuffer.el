;;; robenkleene-ibuffer.el --- robenkleene-ibuffer
;;; Commentary:
;;; Code:

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-do-sort-by-major-mode)
            )
          )

(provide 'robenkleene-ibuffer)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ibuffer.el ends here
