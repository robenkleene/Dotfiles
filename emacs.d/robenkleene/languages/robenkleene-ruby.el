;;; robenkleene-ruby.el --- robenkleene-ruby
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package enh-ruby-mode
  :mode ("\\.rb$" "Fastfile$")
  :interpreter "ruby"
  :config
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  )

(use-package robe
  :defer t
  :init
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  (eval-after-load 'company
    '(push 'company-robe company-backends))
  )


(provide 'robenkleene-ruby)
;;; robenkleene-ruby.el ends here

