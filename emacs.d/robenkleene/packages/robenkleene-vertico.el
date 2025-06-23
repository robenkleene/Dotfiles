;;; robenkleene-vertico.el --- robenkleene-vertico
;;; Commentary:
;;; Code:

(use-package vertico
  :init
  (vertico-mode)
  )

(use-package consult
  :bind (
         ("M-g i" . consult-imenu)
         ("M-s M-f" . consult-fd)
         ("C-x b" . consult-buffer)
         ("M-s M-g" . consult-ripgrep)
         ("M-s o" . consult-line)
         )
  :init
  ;; Time to wait before updating results, the default is `0.2'
  ;; Decreasing this makes `consult' feel significantly more responsive
  (setq consult-async-input-debounce 0.05)
  ;; Never use `consult' built-in project functions Without this, e.g.,
  ;; `consult-ripgrep' won't use the current directory and instead look for a
  ;; project
  (setq consult-project-function nil)

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
