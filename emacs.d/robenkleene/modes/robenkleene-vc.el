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

  ;; `hg' commands just hang too often, comment these out to remind me not to run
  ;; them
  ;; (defadvice vc-print-log (before rk/vc-print-log-hg)
  ;;   "Support for `hg'"
  ;;   (setq-local vc-handled-backends
  ;;               (cons #'Hg
  ;;                     vc-handled-backends))
  ;;   )

  ;; (defadvice vc-print-root-log (before rk/vc-print-root-log-hg)
  ;;   "Support for `hg'"
  ;;   (setq-local vc-handled-backends
  ;;               (cons #'Hg
  ;;                     vc-handled-backends))
  ;;   )

  ;; (defadvice vc-cd-vc-root (before rk/vc-cd-vc-root-hg)
  ;;   "Support for `hg'"
  ;;   (setq-local vc-handled-backends
  ;;               (cons #'Hg
  ;;                     vc-handled-backends))
  ;;   )

  ;; (defadvice vc-root-diff (before rk/vc-root-diff-hg)
  ;;   "Support for `hg'"
  ;;   (setq-local vc-handled-backends
  ;;               (cons #'Hg
  ;;                     vc-handled-backends))
  ;;   )

  ;; (defun rk/vc-print-log-startup ()
  ;;   "`vc' log in current window."
  ;;   (interactive)
  ;;   (progn (call-interactively 'vc-print-log)
  ;;          (delete-other-windows))
  ;;   )
  )


(provide 'robenkleene-vc)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vc.el ends here
