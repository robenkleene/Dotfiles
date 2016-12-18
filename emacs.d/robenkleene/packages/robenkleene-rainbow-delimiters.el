;;; robenkleene-rainbow-delimiters.el --- robenkleene-rainbow-delimiters
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(provide 'robenkleene-rainbow-delimiters)
;;; robenkleene-rainbow-delimiters.el ends here
