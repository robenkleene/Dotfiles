;;; robenkleene-eshell.el --- robenkleene-eshell
;;; Commentary:
;;; Code:

(with-eval-after-load 'eshell

  ;; Show tab completion options instead of just choosing one
  (setq eshell-cmpl-cycle-completions nil)
  (add-hook
   'eshell-mode-hook
   (lambda ()
     (setq pcomplete-cycle-completions nil)
     ;; Bindings
     (define-key eshell-mode-map (kbd "C-u") 'eshell-kill-input)
     )
   )
  )

(provide 'robenkleene-eshell)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eshell.el ends here
