;;; robenkleene-ido-completing-read.el --- robenkleene-ido-completing-read
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

;; Hack to prevent some compilation errors
(defvar ido-cur-list nil)

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1))

(provide 'robenkleene-ido-completing-read)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ido-completing-read.el ends here
