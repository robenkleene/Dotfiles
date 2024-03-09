;;; robenkleene-text.el --- robenkleene-text
;;; Commentary:
;;; Code:

;; Wrap in text modes
(add-hook 'text-mode-hook (lambda ()
                            (set 'truncate-lines nil)
                            ))

(provide 'robenkleene-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-text.el ends here
