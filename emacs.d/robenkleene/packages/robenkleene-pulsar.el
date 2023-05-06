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
  (add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)
  (add-hook 'next-error-hook #'pulsar-pulse-line)
  (add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
  (setq pulsar-delay 0.1)
  (setq pulsar-face 'pulsar-magenta)
  )

(provide 'robenkleene-pulsar)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-pulsar.el ends here


