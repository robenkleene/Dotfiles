;;; robenkleene-text.el --- robenkleene-text
;;; Commentary:
;;; Code:

(with-eval-after-load 'text
  (define-key text-mode-map (kbd "M-n")
    'next-error)
  (define-key text-mode-map (kbd "M-p")
    'previous-error)
  (define-key text-mode-map (kbd "M-r")
    'robenkleene/reveal-in-finder)
  )

(provide 'robenkleene-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-text.el ends here
