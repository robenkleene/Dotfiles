;;; robenkleene-pbcopy.el --- robenkleene-pbcopy
;;; Commentary:
;;; Code:


(use-package pbcopy
  :if (and (robenkleene/system-is-mac) (not (display-graphic-p)))
      :init (turn-on-pbcopy))

(provide 'robenkleene-pbcopy)
;;; robenkleene-pbcopy.el ends here
