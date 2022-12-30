;;; robenkleene-csv.el --- robenkleene-csv
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package csv-mode
  :mode "\\.csv\\'")

(provide 'robenkleene-csv)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-csv.el ends here
