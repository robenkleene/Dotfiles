(rk-install-package-if-missing 'inf-ruby)

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-s-r") 'rk-ruby-toggle-irb)
     (define-key ruby-mode-map (kbd "<C-s-268632082>") 'rk-ruby-toggle-irb)
     (define-key ruby-mode-map (kbd "s-r") 'rk-ruby-run-buffer-or-region)
     ;; (define-key ruby-mode-map (kbd "C-S-e") 'ruby-send-block)
     (define-key ruby-mode-map (kbd "C-S-e") 'ruby-send-block)
     ))

(eval-after-load 'inf-ruby
  '(progn
     (define-key inf-ruby-mode-map (kbd "C-p") 'comint-previous-input)
     (define-key inf-ruby-mode-map (kbd "C-n") 'comint-next-input)
     ))

(defun rk-ruby-toggle-irb ()
  (interactive)
  (if (null (get-buffer "*ruby*"))
      (rk-ruby-start-irb)))
(defun rk-ruby-start-irb ()
  (interactive)
;;  (add-hook 'irb-connected-hook 'rk-window-resize-for-shell)
  (run-ruby)
  (rk-window-resize-for-shell)
  )

(defun rk-ruby-run-buffer-or-region ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'ruby-send-region)
    (rk-ruby-send-buffer)))

(defun rk-ruby-send-buffer ()
  (interactive)
  (ruby-send-region (point-min) (point-max)))

(provide 'rk-ruby)
