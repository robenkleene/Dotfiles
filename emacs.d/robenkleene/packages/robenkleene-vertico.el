;;; robenkleene-vertico.el --- robenkleene-vertico
;;; Commentary:
;;; Code:

(use-package vertico
  :bind
  (:map vertico-map
        ;; Display possible completions (like `<tab>` for default interface)
        ("?" . 'minibuffer-completion-help)
        )
  :init
  (vertico-mode)
  )

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode)
  )

(provide 'robenkleene-vertico)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vertico.el ends here
