;;; robenkleene-swift.el --- robenkleene-swift
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package swift-mode
  :mode "\\.swift\\'"
  ;; :config
  ;; (add-hook 'swift-mode-hook
  ;;           (lambda ()
  ;;             ))
  )

(provide 'robenkleene-swift)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-swift.el ends here
