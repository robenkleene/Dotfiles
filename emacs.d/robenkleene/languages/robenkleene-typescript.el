;;; robenkleene-typescript.el --- robenkleene-typescript
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package typescript-mode
  :mode "\\.ts\\'")

(provide 'robenkleene-typescript)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-typescript.el ends here

