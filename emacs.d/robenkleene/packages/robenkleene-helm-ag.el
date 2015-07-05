;;; robenkleene-helm-ag.el --- robenkleene-helm-ag
;;; Commentary:
;;; Code:

(require 'use-package)
(defvar helm-ag)
(use-package helm-ag
  :defer t
  :config
  (progn
    ;; Enable grep mode after saving `helm-ag' results
    (defadvice helm-ag--save-results (after robenkleene/helm-ag-grep-mode (args) activate)
      (with-current-buffer (get-buffer-create "*helm ag results*")
        (grep-mode)
        )
      )
    )
  )

(provide 'robenkleene-helm-ag)
;;; robenkleene-helm-ag.el ends here
