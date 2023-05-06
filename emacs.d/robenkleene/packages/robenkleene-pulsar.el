;;; robenkleene-pulsar.el --- robenkleene-pulsar
;;; Commentary:
;;; Code:


(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package pulsar
  :init
  (pulsar-global-mode)
  ;; integration with the `consult' package:
  (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)

  ;; integration with the built-in `imenu':
  (add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
  )

(provide 'robenkleene-pulsar)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-pulsar.el ends here


