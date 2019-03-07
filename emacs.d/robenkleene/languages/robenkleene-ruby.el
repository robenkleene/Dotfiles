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

(with-eval-after-load "ruby-mode"
  (setq robenkleene/format-program "rubocop --auto-correct --stdin - 2>&1 | sed '1,/^====================$/d'")
  (define-key robenkleene/leader-map (kbd "f") (lambda ()
                                                 (interactive)
                                                 (robenkleene/format)
                                                 ;; For some reason running
                                                 ;; format kill syntax
                                                 ;; highlighting in Ruby,
                                                 ;; calling `ruby-mode'
                                                 ;; re-applies it
                                                 (ruby-mode)
                                                 ))
  )

(provide 'robenkleene-ruby)
;;; robenkleene-ruby.el ends here
