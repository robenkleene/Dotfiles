;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

;; Load `C-x C-j' command for `dired-jump'
;; Also enables `dired-omit-mode'
(require 'dired-x)

(with-eval-after-load 'dired
  (defun robenkleene/dired-toggle-hidden ()
    "Show/hide hidden files except . and .."
    (interactive)
    (setq dired-omit-mode (not dired-omit-mode))
    (revert-buffer)
    )
  ;; Make `C-x j' also do `dired-jump' (which `C-x C-j' already does)
  (global-set-key (kbd "C-x j") 'dired-jump)

  (define-key dired-mode-map (kbd "C-c g h") 'robenkleene/dired-toggle-hidden)
  (define-key dired-mode-map (kbd "<mouse-2>") 'dired-find-file)
  ;; Suppress error message
  (defvar dired-use-ls-dired)
  (setq dired-use-ls-dired nil)

  ;; Don't show "omitted lines" message
  (setq dired-omit-verbose nil)

  ;; If two `dired' buffers are open, use the other window as the default
  ;; destination for operations like rename and copy.
  (setq dired-dwim-target t)
  ;; Omit hidden files
  ;; Omit hidden files (`^\\..+$\\') and macOS icon files (`Icon\015+')
  (setq-default dired-omit-files
                (concat dired-omit-files "\\|^\\..+$\\|Icon\015+"))
  )
(add-hook 'dired-mode-hook
          (lambda ()
            ;; Highlight current line
            (hl-line-mode)
            ;; Some attempts to use the default `find-file` behavior in Dired to
            ;; make it easy to create a new file. Neither of these work.
            ;; (define-key dired-mode-map (kbd "C-x C-f") 'find-file)
            ;; (local-set-key (kbd "C-x C-f") #'find-file)
            (dired-omit-mode)
            ;; Hide details (showthem with "\("
            (dired-hide-details-mode)
            ;; Auto-refresh on file system change
            (auto-revert-mode)
            (setq-local robenkleene/archive-function
                        (lambda ()
                          (interactive)
                          (dired-do-shell-command
                           "~/.bin/backup_file"
                           nil
                           (dired-get-marked-files))
                          ))
            (setq-local ido-use-filename-at-point nil)
            )
          )

(provide 'robenkleene-dired)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-dired.el ends here
