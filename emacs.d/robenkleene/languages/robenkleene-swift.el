;;; robenkleene-swift.el --- robenkleene-swift
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package swift-mode
  :defer t
  :config
  (add-hook 'swift-mode-hook
            (lambda ()
              ))
  )

(provide 'robenkleene-swift)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-swift.el ends here
