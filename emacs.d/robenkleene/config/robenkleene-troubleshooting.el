;;; robenkleene-troubleshooting.el --- robenkleene-troubleshooting
;;; Commentary:
;;; Code:

;; Improve scrolling
;; Both `scroll-conservatively' and `scroll-margin' together help prevent emacs
;; from getting "stuck" (bouncing back) when trying to scroll the cursor off
;; screen
(setq scroll-conservatively 101)
;; Size of buffer from bottom of the screen when scrolling
(setq scroll-margin 1)


(provide 'robenkleene-troubleshooting)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-troubleshooting.el ends here
