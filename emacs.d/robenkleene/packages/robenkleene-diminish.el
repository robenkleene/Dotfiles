;;; robenkleene-diminish.el --- robenkleene-diminish
;;; Commentary:
;;; Code:

(use-package diminish
  :init
  (diminish 'abbrev-mode)
  (diminish 'auto-revert-mode)
  (diminish 'eldoc-mode)
  (with-eval-after-load 'whitespace
    (diminish 'whitespace-mode)
    )
  (with-eval-after-load 'flyspell
    (diminish 'flyspell-mode)
    )
  )

(provide 'robenkleene-diminish)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-diminish.el ends here
