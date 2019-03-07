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
  ;; (eval-after-load 'company
  ;;   '(push 'company-robe company-backends))
  )

(with-eval-after-load "ruby-mode"
  (setq robenkleene/format-program "rubocop --auto-correct --stdin - 2>&1 | sed '1,/^====================$/d'")

  ;; (defvar robenkleene/ruby-bindings-map (make-keymap))
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
  (define-key robenkleene/leader-map (kbd "e") 'robenkleene/ruby-eval-buffer-or-region)
  (defalias 'repl 'robenkleene/start-irb)

  (defun robenkleene/start-irb ()
    (interactive)
    (if (null (get-buffer "*ruby*"))
        (run-ruby)
      (switch-to-buffer-other-window "*ruby*")
      )
    )

  (defun robenkleene/ruby-eval-buffer-or-region ()
    (interactive)
    (if (use-region-p)
        (call-interactively 'ruby-send-region)
      (call-interactively 'ruby-send-buffer)
      )
    (switch-to-buffer-other-window "*ruby*")
    )

  ;; Mode
  ;; (define-minor-mode robenkleene/ruby-bindings-minor-mode
  ;;   "My bindings."
  ;;   t
  ;;   nil
  ;;   'robenkleene/ruby-bindings-map)
  ;; (robenkleene/ruby-bindings-minor-mode 1)
  )

(provide 'robenkleene-ruby)
;;; robenkleene-ruby.el ends here
