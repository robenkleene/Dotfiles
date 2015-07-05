;;; robenkleene-jade.el --- robenkleene-jade
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package jade-mode
  :ensure t
  :defer t)

;; TODO: This doesn't work for some reason
;; (add-hook 'jade-mode-hook 'robenkleene/highlight-keywords)

(provide 'robenkleene-jade)
;;; robenkleene-jade.el ends here
