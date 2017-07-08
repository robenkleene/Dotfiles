;;; robenkleene-fill-column-indicator.el --- robenkleene-fill-column-indicator
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package fill-column-indicator
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'fci-mode)
  :config
  ;; This color isn't accurate for some reason
  (setq fci-rule-color "#444444")
  (setq fci-rule-column 80)
  )

(provide 'robenkleene-fill-column-indicator)
;;; robenkleene-fill-column-indicator.el ends here
