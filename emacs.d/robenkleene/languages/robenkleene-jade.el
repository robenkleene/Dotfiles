;;; robenkleene-jade.el --- robenkleene-jade
;;; Commentary:
;;; Code:

(load "~/.emacs.d/init-use-package.el")
(use-package jade-mode
  :mode "\\.jade\\'")

;; TODO: This doesn't work for some reason
;; (add-hook 'jade-mode-hook 'robenkleene/highlight-keywords)

(provide 'robenkleene-jade)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-jade.el ends here
