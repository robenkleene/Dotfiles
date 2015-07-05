;;; robenkleene-evil-commentary.el --- robenkleene-evil-commentary
;;; Commentary:
;;; Code:

(require 'use-package)
(defvar evil-commentary)
(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode)
  )

(provide 'robenkleene-evil-commentary)
;;; robenkleene-evil-commentary.el ends here
