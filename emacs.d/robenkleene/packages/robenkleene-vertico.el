;;; robenkleene-vertico.el --- robenkleene-vertico
;;; Commentary:
;;; Code:

(use-package vertico
  :init
  (vertico-mode)
  )

(use-package consult
  :bind (
         ("M-g M-i" . consult-imenu)
         ("M-s M-g" . consult-ripgrep)
         ("M-s M-f" . consult-fd)
         ("M-s M-o" . consult-line)
         )
  :init
  ;; Time to wait before updating results, the default is `0.2'
  ;; Decreasing this makes `consult' feel significantly more responsive
  (setq consult-async-input-debounce 0.05)
  )

;; Orderless makes regular fuzzy matching work, without it a search for a
;; filename will have to start with the start of that filename
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'robenkleene-vertico)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vertico.el ends here
