;;; robenkleene-ruby.el --- robenkleene-ruby
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package enh-ruby-mode
  :ensure t
  :mode "\\.rb$"
  :interpreter "ruby"
  :config
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  )

(use-package robe
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'enh-ruby-mode-hook 'robe-mode)
    (eval-after-load 'company
      '(push 'company-robe company-backends))
    )
  )

(provide 'robenkleene-ruby)
;;; robenkleene-ruby.el ends here

