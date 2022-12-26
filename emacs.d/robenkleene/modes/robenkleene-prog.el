;;; robenkleene-prog.el --- robenkleene-prog
;;; Commentary:
;;; Code:

(with-eval-after-load 'prog-mode
  (define-key prog-mode-map (kbd "M-n")
    'next-error)
  (define-key prog-mode-map (kbd "M-p")
    'previous-error)
  (define-key text-mode-map (kbd "M-r")
    'robenkleene/reveal-in-finder)
  )

(provide 'robenkleene-prog)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-prog.el ends here
