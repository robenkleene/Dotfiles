;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package evil
  :ensure t
  :config

  (require 'robenkleene-evil-settings)
  (require 'robenkleene-evil-motion-state-map)
  (require 'robenkleene-evil-unimpaired-map)
  (require 'robenkleene-evil-leader-map)
  (require 'robenkleene-evil-dired)

  (evil-mode 1)
  )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here


