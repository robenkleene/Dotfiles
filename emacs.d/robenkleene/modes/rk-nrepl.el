(provide 'rk-nrepl)

(rk-install-package-if-missing 'nrepl)

(eval-after-load "clojure-mode"
  '(progn
     (define-key geiser-mode-map (kbd "s-r") 'rk-nrepl-eval-buffer-or-region)
     (define-key geiser-mode-map (kbd "C-E") 'nrepl-eval-last-expression)
     ))

(defun rk-nrepl-eval-buffer-or-region ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'nrepl-eval-region)
    (nrepl-load-current-buffer)))
