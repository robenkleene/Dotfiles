;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

(with-eval-after-load 'dired
  ;; Load `C-x C-j' command for `dired-jump'
  ;; Also enables `dired-omit-mode'
  (require 'dired-x)

  ;; This is `dired-find-file-other-window' by default
  ;; This is inconsistent with other modes, e.g., `org-mode' follows links in
  ;; the other window
  ;; (define-key dired-mode-map (kbd "<mouse-2>") 'dired-find-file)

  ;; Don't ask `Kill buffer of' when deleting a buffer, just kill it
  (setq dired-clean-confirm-killing-deleted-buffers nil)

  ;; Don't show "omitted lines" message
  (setq dired-omit-verbose nil)

  ;; Suppress `ls does not support --dired' warning
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil))

  (add-hook 'dired-mode-hook
            (lambda ()
              ;; Definitely need this because lack of colors in Dired mode means
              ;; it's hard to tell the details from the filename
              (dired-hide-details-mode)
              ;; Auto-refresh on file system change
              (auto-revert-mode)
              )
            )
  )

(provide 'robenkleene-dired)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-dired.el ends here
