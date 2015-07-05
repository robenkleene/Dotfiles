;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(require 'use-package)
(defvar helm)
(use-package helm
  :bind (
         ("M-x" . helm-M-x)
         ("C-x C-b" . helm-buffers-list)
         )
  :config
  (progn
    (helm-mode 1)
    (defvar helm-trnucate-lines)
    (setq helm-truncate-lines t)
    (custom-set-faces
     `(helm-match ((t (:foreground nil :background nil :bold nil :inherit isearch))))
     `(helm-ff-directory ((t (:inherit dired-directory))))
     `(helm-ff-dotted-directory ((t (:inherit dired-directory))))
     `(helm-ff-file ((t (:inherit diredp-file-name))))
     `(helm-moccur-buffer ((t (:inherit button))))
     )
    )
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
