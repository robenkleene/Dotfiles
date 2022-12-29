;;; init-use-package.el --- init-use-package
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))

(provide 'init-use-package)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; init-use-package.el ends here
