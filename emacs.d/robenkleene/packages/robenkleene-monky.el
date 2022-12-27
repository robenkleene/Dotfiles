;;; robenkleene-monky.el --- robenkleene-monky
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package monky
  :commands
  (monky-status)
  :init
  (setq monky-process-type 'cmdserver)
  )

(provide 'robenkleene-monky)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-monky.el ends here
