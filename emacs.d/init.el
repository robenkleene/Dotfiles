;;; init.el --- init
;;; Commentary:
;;; Code:

;; Without this, using `package.el` will add this content to this file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene"))
(require 'robenkleene)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; init.el ends here
