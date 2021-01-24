;;; robenkleene-move-text.el --- robenkleene-move-text
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package move-text
  :ensure t
  :bind
  ("M-<down>" . move-text-down)
  ("M-<up>" . move-text-up)
  )

(provide 'robenkleene-move-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-move-text.el ends here
