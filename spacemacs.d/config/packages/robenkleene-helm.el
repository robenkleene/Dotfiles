;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(eval-after-load 'helm
  '(progn
     ;; Truncate long lines
     (defvar helm-truncate-lines)
     (setq helm-truncate-lines t)
     )
  )

(provide 'robenkleene-helm)

;;; robenkleene-helm.el ends here
