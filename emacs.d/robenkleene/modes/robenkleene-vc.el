;;; robenkleene-vc.el --- robenkleene-vc
;;; Commentary:
;;; Code:

;; Removes massive slow down with large `hg' repos
(setq vc-handled-backends '(Git))
;; `git' has an annoying message when following symlinks:
;; This instead follows the link and echos
;; Display in echo area
;; (setq vc-follow-symlinks t)
;; This just edits the file in place and ignores `vc' features
(setq vc-follow-symlinks nil)
;; This is still slow with large code bases
;; `find-file-hook' can cause slow behavior
(remove-hook 'find-file-hook 'vc-find-file-hook)

;; Another potential slowdown
(setq vc-hg-parse-hg-data-structures nil)
(setq vc-log-show-limit 100)

(defadvice vc-print-log (before rk/vc-print-log-hg)
  "Support for `hg'"
  (setq-local vc-handled-backends
              (cons #'Hg
                    vc-handled-backends))
  )

(provide 'robenkleene-vc)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vc.el ends here
