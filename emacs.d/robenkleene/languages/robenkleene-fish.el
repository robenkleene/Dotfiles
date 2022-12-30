;;; robenkleene-fish.el --- robenkleene-fish
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package fish-mode
  :mode "\\.fish\\'"
  :config
  (add-hook 'fish-mode-hook
            (lambda ()

              ))
  )

(provide 'robenkleene-fish)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-fish.el ends here
