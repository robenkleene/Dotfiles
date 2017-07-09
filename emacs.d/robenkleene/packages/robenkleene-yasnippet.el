;;; robenkleene-yasnippet.el --- yasnippet
;;; Commentary:
;;; Code:


(require 'use-package)
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-reload-all)
  )

(provide 'robenkleene-yasnippet)
;;; robenkleene-yasnippet.el ends here

