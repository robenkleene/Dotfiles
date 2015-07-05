;;; robenkleene-pbcopy.el --- robenkleene-pbcopy
;;; Commentary:
;;; Code:

(require 'robenkleene-functions)

(require 'use-package)
(use-package pbcopy
  :ensure t
  :if (and (robenkleene/system-is-mac) (not (display-graphic-p)))
  :init (turn-on-pbcopy)
  )

(provide 'robenkleene-pbcopy)
;;; robenkleene-pbcopy.el ends here
