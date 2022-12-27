;;; robenkleene-esup.el --- robenkleene-esup
;;; Commentary:
;;; Code:

(use-package esup
  :ensure t
  :init
  ;; This fixes a bug when running `esup', alas it also makes the results
  ;; useless
  (setq esup-depth 1)
  :commands (esup))

(provide 'robenkleene-esup)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-esup.el ends here
