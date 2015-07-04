;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

;; Use helm M-x


;; Use helm everywhere
(use-package helm
	     :defer t
	     :init
		 (progn
  			 (global-set-key (kbd "M-x") 'helm-M-x)
  			 (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
			 (helm-mode 1)
			(custom-set-faces
			 `(helm-match ((t (:foreground nil :background nil :bold nil :inherit isearch))))
			 `(helm-ff-directory ((t (:inherit dired-directory))))
			 `(helm-ff-dotted-directory ((t (:inherit dired-directory))))
			 `(helm-ff-file ((t (:inherit diredp-file-name))))
			 `(helm-moccur-buffer ((t (:inherit button))))
			 )
		 )
		 :config
		 (progn 
		      (setq helm-truncate-lines t)
		 )
	     )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
