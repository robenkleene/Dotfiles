;;; robenkleene-ef-themes.el --- robenkleene-ef-themes
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package ef-themes
  :config
  ;; (ef-themes-select 'ef-winter)
  )

(provide 'robenkleene-ef-themes)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ef-themes.el ends here
