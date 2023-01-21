;;; robenkleene-diminish.el --- robenkleene-diminish
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package diminish
  :init
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
