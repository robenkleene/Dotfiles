;;; robenkleene-text.el --- robenkleene-text
;;; Commentary:
;;; Code:

(add-hook 'text-mode-hook (lambda ()
                            ;; Wrap in text modes
                            (set 'truncate-lines nil)
                            ;; Spelling
                            (flyspell-mode)
                            ;; Show trailing whitespace
                            (setq-local show-trailing-whitespace t)
                            ))

(provide 'robenkleene-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-text.el ends here
