(provide 'rk-emacs-lisp)


(eval-after-load "lisp-mode"
  '(progn
     (define-key emacs-lisp-mode-map (kbd "s-r") 'rk-eval-emacs-lisp)
     (define-key lisp-interaction-mode-map (kbd "s-r") 'rk-eval-emacs-lisp)
     (define-key emacs-lisp-mode-map (kbd "C-E") 'eval-last-sexp)
     (define-key lisp-interaction-mode-map (kbd "C-E") 'eval-last-sexp)
     ))

(defun rk-eval-emacs-lisp ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'eval-region)
      (eval-buffer)))
