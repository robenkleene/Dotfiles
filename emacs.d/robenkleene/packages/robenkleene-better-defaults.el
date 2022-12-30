;;; robenkleene-better-defaults.el --- robenkleene-better-defaults
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package better-defaults)

(provide 'robenkleene-better-defaults)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-better-defaults.el ends here
