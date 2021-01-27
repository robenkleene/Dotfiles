;;; robenkleene-multiple-cursors.el --- robenkleene-multiple-cursors
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  )

(provide 'robenkleene-multiple-cursors)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-multiple-cursors.el ends here
