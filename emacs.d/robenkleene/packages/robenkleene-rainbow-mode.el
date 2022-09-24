;;; robenkleene-rainbow-mode.el --- robenkleene-rainbow-mode
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package rainbow-mode
  ;; :commands rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode)
  (add-hook 'text-mode-hook #'rainbow-mode)
  )

(provide 'robenkleene-rainbow-mode)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-rainbow-mode.el ends here
