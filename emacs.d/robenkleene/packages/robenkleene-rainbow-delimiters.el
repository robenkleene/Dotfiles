;;; robenkleene-rainbow-delimiters.el --- robenkleene-rainbow-delimiters
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode
  :init
  (progn
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
    )
  :config
  (progn
    (custom-set-faces
     `(rainbow-delimiters-mismatched-face ((t (:inherit show-paren-mismatch))))
     `(rainbow-delimiters-unmatched-face ((t (:inherit show-paren-mismatch))))
     )
    )
  )

(provide 'robenkleene-rainbow-delimiters)
;;; robenkleene-rainbow-delimiters.el ends here
