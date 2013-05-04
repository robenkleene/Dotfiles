(rk-install-package-if-missing 'inf-ruby)

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-s-r") 'rk-ruby-toggle-irb)
     (define-key ruby-mode-map (kbd "<C-s-268632082>") 'rk-ruby-toggle-irb)
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

(provide 'rk-ruby)
