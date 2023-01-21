;;; robenkleene-rainbow-mode.el --- robenkleene-rainbow-mode
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package rainbow-mode
  ;; :commands rainbow-mode
  :diminish
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode)
  (add-hook 'text-mode-hook #'rainbow-mode)
  )

(provide 'robenkleene-rainbow-mode)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-rainbow-mode.el ends here
