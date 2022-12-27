;;; robenkleene-esop.el --- robenkleene-esop
;;; Commentary:
;;; Code:

(use-package esup
  :init
  ;; This fixes a bug when running `esup', alas it also makes the results
  ;; useless
  (setq esup-depth 0)
  :commands (esup))

(provide 'robenkleene-esop)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-esop.el ends here
