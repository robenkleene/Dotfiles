;;; robenkleene-pbcopy.el --- robenkleene-pbcopy
;;; Commentary:
;;; Code:

(require 'robenkleene-functions)

(eval-when-compile (require 'use-package))
(use-package pbcopy
  :if (and (robenkleene/system-is-mac) (not (display-graphic-p)))
  :init (turn-on-pbcopy)
  )

(provide 'robenkleene-pbcopy)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-pbcopy.el ends here
