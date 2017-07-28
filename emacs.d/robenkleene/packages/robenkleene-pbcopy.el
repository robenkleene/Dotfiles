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
;;; robenkleene-pbcopy.el ends here
