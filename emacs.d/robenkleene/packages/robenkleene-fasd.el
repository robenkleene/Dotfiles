;;; robenkleene-fasd.el --- robenkleene-fasd
;;; Commentary:
;;; Code:


(eval-when-compile (require 'use-package))
(use-package fasd
  :bind (:map robenkleene/leader-map
              ("z" . fasd-find-file)
              )
  :config
  (global-fasd-mode 1)
  )

(provide 'robenkleene-fasd)
;;; robenkleene-fasd.el ends here

