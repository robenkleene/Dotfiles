;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

;; Use helm M-x
(global-set-key (kbd "M-x") 'helm-M-x)

;; Use helm everywhere
(use-package helm
	     :defer t
	     :init
	     (helm-mode 1)
	     )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
