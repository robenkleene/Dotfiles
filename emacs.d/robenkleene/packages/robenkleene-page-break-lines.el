;;; robenkleene-page-break-lines.el --- robenkleene-page-break-lines
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package page-break-lines
  :init
  (global-page-break-lines-mode)
  )

(provide 'robenkleene-page-break-lines)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-page-break-lines.el ends here
