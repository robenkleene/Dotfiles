;;; robenkleene-lua.el --- robenkleene-lua
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package lua-mode
  :mode "\\.lua\\'")

(provide 'robenkleene-lua)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-lua.el ends here
