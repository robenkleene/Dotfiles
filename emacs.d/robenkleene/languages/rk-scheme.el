(rk-install-package-if-missing 'geiser)

;; Paredit
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; Scheme
(eval-after-load 'geiser
  '(progn
     (setq geiser-active-implementations '(racket))
     (setq geiser-racket-binary "/usr/local/bin/racket")
     ))
(eval-after-load "geiser-mode"
  '(progn
     (define-key geiser-mode-map (kbd "s-r") 'geiser-eval-region)
     (define-key geiser-mode-map (kbd "C-E") 'geiser-eval-last-sexp)
     ))


;; (defun rk-eval-lisp ()
;;   (interactive)
;;   (if (use-region-p)
;;       (call-interactively 'eval-region)
;;       (eval-buffer)))


(provide 'rk-scheme)
