(provide 'rk-emacs-lisp)


(eval-after-load "lisp-mode"
  '(progn
     (define-key emacs-lisp-mode-map (kbd "s-r") 'rk-eval-lisp)
     (define-key lisp-interaction-mode-map (kbd "s-r") 'rk-eval-lisp)
  )
)

(defun rk-eval-lisp ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'eval-region)
      (eval-buffer)))
