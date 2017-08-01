;;; robenkleene-yasnippet.el --- yasnippet
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package yasnippet
  :commands yas-minor-mode
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'markdown-mode-hook '(lambda()
                                   ;; Disable `markdown-mode-map' tab key
                                   (define-key markdown-mode-map (kbd "C-i") nil)
                                   (yas-minor-mode)
                                   )
            )
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-reload-all)
  ;; Allow recursive snippet expansion
  (setq yas-triggers-in-field t)
  )

(provide 'robenkleene-yasnippet)
;;; robenkleene-yasnippet.el ends here
