;;; robenkleene-flyspell-lazy.el --- robenkleene-flyspell-lazy
;;; Commentary:
;;; Code:


(use-package flyspell-lazy
  :after flyspell
  :hook
  (flyspell-mode . flyspell-lazy-mode)
  )

(provide 'robenkleene-flyspell-lazy)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-flyspell-lazy.el ends here
