;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package helm
  :ensure t
  :commands helm-recentf
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
    )
  )

(provide 'robenkleene-helm)
;;; robenkleene-helm.el ends here
