;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

(with-eval-after-load 'dired
  ;; Load `C-x C-j' command for `dired-jump'
  ;; Also enables `dired-omit-mode'
  (require 'dired-x)

  ;; Suppress error message
  ; (defvar dired-use-ls-dired)
  ; (setq dired-use-ls-dired nil)

  ;; Don't ask `Kill buffer of' when deleting a buffer, just kill it
  (setq dired-clean-confirm-killing-deleted-buffers nil)

  ;; Don't show "omitted lines" message
  (setq dired-omit-verbose nil)

  ;; When deleting a directory, always also kill the corresponding Dired buffer
  (defadvice rk/dired-delete-entry (before force-clean-up-buffers (file) activate)
    (kill-buffer (get-file-buffer file)))


  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map (kbd "`") 'eshell-other-window)

              ;; Definitely need this because lack of colors in Dired mode means
              ;; it's hard to tell the details from the filename
              (dired-hide-details-mode)
              ;; Auto-refresh on file system change
              (auto-revert-mode)

              ;; Add to `z' The reason we do this in Emacs `dired-mode', but not
              ;; say `netrw' in Vim is because Vim works more naturally with the
              ;; terminal, so usually in Vim the important directory has already
              ;; been added
              (rk/z-add)
              )
            )
  )

(provide 'robenkleene-dired)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-dired.el ends here
