;;; robenkleene-outline.el --- robenkleene-outline
;;; Commentary:
;;; Code:

(with-eval-after-load 'outline
  (define-key outline-mode-map (kbd "C-c >") 'outline-demote)
  (define-key outline-mode-map (kbd "C-c <") 'outline-promote)
  )

(provide 'robenkleene-outline)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-outline.el ends here
