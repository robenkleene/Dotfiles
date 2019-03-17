;;; robenkleene-ruby.el --- robenkleene-ruby
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package enh-ruby-mode
  :mode ("\\.rb$" "Fastfile$")
  :interpreter "ruby"
  :config
  (add-hook 'enh-ruby-mode-hook
            (lambda ()
              (setq-local robenkleene/format-program
                          "rubocop --auto-correct --stdin - 2>&1 | sed '1,/^====================$/d'")
              (setq-local robenkleene/format-function
                          (lambda ()
                            (interactive)
                            (if (bound-and-true-p robenkleene/format-program)
                                (progn
                                  (robenkleene/shell-command-on-buffer-or-region
                                   robenkleene/format-program)
                                  )
                              (message "No format program defined.")
                              )
                            ;; For some reason running
                            ;; format kill syntax
                            ;; highlighting in Ruby,
                            ;; calling `ruby-mode'
                            ;; re-applies it
                            ;; (enh-ruby-mode)
                            ))
              (setq-local robenkleene/evaluate-buffer-or-region-function
                          'robenkleene/ruby-eval-buffer-or-region)
              ;; Remove `:' from the symbol syntax table this helps makes
              ;; jumping to definition work
              (let ((table (copy-syntax-table (syntax-table))))
                (modify-syntax-entry ?: "." table)
                (set-syntax-table table)
                )
              )
            )

  (with-eval-after-load "enh-ruby-mode"
    ;; (defvar robenkleene/ruby-bindings-map (make-keymap))

    (defalias 'irb 'robenkleene/start-irb)

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
  )

(use-package inf-ruby
  :init
  (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

;; (use-package robe
;;   :defer t
;;   :init
;;   (add-hook 'enh-ruby-mode-hook 'robe-mode)
;;   ;; (eval-after-load 'company
;;   ;;   '(push 'company-robe company-backends))
;;   )

(provide 'robenkleene-ruby)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ruby.el ends here
