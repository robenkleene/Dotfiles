;;; robenkleene-vc.el --- robenkleene-vc
;;; Commentary:
;;; Code:

(with-eval-after-load 'vc
  ;; Removes massive slow down with large `hg' repos
  (setq vc-handled-backends nil)
  ;; Even `git' has slow downs when opening files
  ;; (setq vc-handled-backends '(Git))
  ;; `git' has an annoying message when following symlinks:
  ;; This instead follows the link and echos
  ;; Display in echo area
  ;; (setq vc-follow-symlinks t)

  ;; This just edits the file in place and ignores `vc' features
  ;; This breaks detection of the current backend.
  ;; E.g., `vc-dir-root' will fail while editing a dotfile
  ;; (setq vc-follow-symlinks nil)

  ;; This is still slow with large code bases
  ;; `find-file-hook' can cause slow behavior
  (remove-hook 'find-file-hook 'vc-find-file-hook)

  ;; Another potential slowdown
  (setq vc-hg-parse-hg-data-structures nil)
  (setq vc-log-show-limit 100)
  )

(provide 'robenkleene-vc)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vc.el ends here
