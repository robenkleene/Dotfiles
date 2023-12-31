;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

;; Load `C-x C-j' command for `dired-jump'
;; Also enables `dired-omit-mode'
(require 'dired-x)

(with-eval-after-load 'dired
  (defun rk/dired-toggle-hidden ()
    "Show/hide hidden files except . and .."
    (interactive)
    (setq dired-omit-mode (not dired-omit-mode))
    (revert-buffer)
    )
  ;; Make `C-x j' also do `dired-jump' (which `C-x C-j' already does)
  ;; (global-set-key (kbd "C-x j") 'dired-jump)

  (define-key dired-mode-map (kbd "C-c .") 'rk/dired-toggle-hidden)
  (define-key dired-mode-map (kbd "<mouse-2>") 'dired-find-file)
  ;; Disable `dired' defaulting to current file completed in `find-file`
  (define-key dired-mode-map (kbd "C-x C-f")
    (lambda () (interactive) (call-interactively 'find-file)))
  (define-key dired-mode-map (kbd "M-o")
    (lambda () (interactive) (call-interactively 'find-file)))

  ;; (define-key dired-mode-map (kbd "-") 'dired-jump)
  (defun rk/dired-open-files (&optional arg)
    "Open marked files."
    (interactive)
    (dired-do-shell-command "open" nil (dired-get-marked-files))
    )
  ;; Suppress error message
  (defvar dired-use-ls-dired)
  (setq dired-use-ls-dired nil)

  ;; Don't ask `Kill buffer of' when deleting a buffer, just kill it
  (setq dired-clean-confirm-killing-deleted-buffers nil)

  ;; Don't show "omitted lines" message
  (setq dired-omit-verbose nil)
  ;; Kill the current buffer when going to new directory
  ;; Can't enable this because then it's hard to open two side-by-side Dired
  ;; buffers
  ;; (setq dired-kill-when-opening-new-dired-buffer t)
  ;; When deleting a directory, always also kill the corresponding Dired buffer
  (defadvice rk/dired-delete-entry (before force-clean-up-buffers (file) activate)
    (kill-buffer (get-file-buffer file)))

  ;; If two `dired' buffers are open, use the other window as the default
  ;; destination for operations like rename and copy.
  ;; Disabling this because it reduces flexibility, e.g., in situations where we
  ;; are setting up a directory structure and want to use another directory for
  ;; reference.
  ;; Instead to move files to another directory:
  ;; 1. First navigate to the destination
  ;; 2. Then navigate to the source
  ;; 3. Use initialize the rename and use `m-n' to find the destination in the
  ;; Dired "future history"
  ;; (setq dired-dwim-target t)
  ;; Omit hidden files
  ;; Omit hidden files (`^\\..+$\\') and macOS icon files (`Icon\015+')
  (setq-default dired-omit-files
                (concat dired-omit-files
                        ;; This one only omits some files
                        ;; "\\|^\.DS_Store\\|^Icon\015+\\|^flycheck_+"
                        ;; This one omits all hidden files
                        "\\|^\\..+$\\|^Icon\015+\\|^flycheck_+"
                        )
                )
  ;; Add `h' for human readable file sizes
  (setq dired-listing-switches "-alh")
  )
(add-hook 'dired-mode-hook
          (lambda ()
            ;; Some attempts to use the default `find-file' behavior in Dired to
            ;; make it easy to create a new file. Neither of these work.
            ;; (define-key dired-mode-map (kbd "C-x C-f") 'find-file)
            ;; Free up `M-s f'
            ;; (define-key dired-mode-map (kbd "M-s f C-s") nil)
            ;; (define-key dired-mode-map (kbd "M-s f C-M-s") nil)
            ;; (local-set-key (kbd "C-x C-f") #'find-file)
            ;; Don't emit hidden files by default because the `.' makes it
            ;; really easy to run a shell command on the current file just by
            ;; selecting the `.' and hitting `!'
            ;; (dired-omit-mode)
            ;; Hide details (show them with open parentheses)
            ;; Definitely need this because lack of colors in Dired mode means
            ;; it's hard to tell the details from the filename
            (dired-hide-details-mode)
            ;; Auto-refresh on file system change
            (auto-revert-mode)
            (setq-local ido-use-filename-at-point nil)
            )
          )

(provide 'robenkleene-dired)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-dired.el ends here
