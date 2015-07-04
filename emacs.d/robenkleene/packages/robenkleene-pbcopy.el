;;; robenkleene-pbcopy.el --- robenkleene-pbcopy
;;; Commentary:
;;; Code:

(require 'pbcopy)

(require 'robenkleene-functions)
(if (and (robenkleene/system-is-mac) (not (display-graphic-p)))
    (turn-on-pbcopy)
    )

(provide 'robenkleene-pbcopy)
;;; robenkleene-pbcopy.el ends here
