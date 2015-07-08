;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package helm
  :ensure t
  :bind (
         ("C-h a" . helm-apropos)
         ("M-x" . helm-M-x)
         ("C-x C-b" . helm-buffers-list)
         )
  :init
  ;; Turn on `helm-mode' here in order to enable completion for `C-h f', etc...
  ;; This could also go in `config' but then default `C-h f' would be used until
  ;; Helm is loaded
  (helm-mode 1)
  :config
  (progn
    ;; (helm-mode 1)
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
