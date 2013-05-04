;; Paredit
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)

;; Lisp Mode
(eval-after-load "lisp-mode"
  '(progn
     (define-key emacs-lisp-mode-map (kbd "s-r") 'rk-emacs-lisp-eval-buffer-or-region)
     (define-key lisp-interaction-mode-map (kbd "s-r") 'rk-emacs-lisp-eval-buffer-or-region)
     (define-key emacs-lisp-mode-map (kbd "C-S-e") 'eval-last-sexp)
     (define-key lisp-interaction-mode-map (kbd "C-S-e") 'eval-last-sexp)
     ))

(defun rk-emacs-lisp-eval-buffer-or-region ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'eval-region)
    (eval-buffer)))


(provide 'rk-emacs-lisp)
