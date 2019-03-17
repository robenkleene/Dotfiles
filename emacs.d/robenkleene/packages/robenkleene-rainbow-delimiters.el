;;; robenkleene-rainbow-delimiters.el --- robenkleene-rainbow-delimiters
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(provide 'robenkleene-rainbow-delimiters)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-rainbow-delimiters.el ends here
