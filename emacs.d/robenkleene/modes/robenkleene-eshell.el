;;; robenkleene-eshell.el --- robenkleene-eshell
;;; Commentary:
;;; Code:

;; (setq eshell-scroll-to-bottom-on-input t)

(with-eval-after-load 'eshell

  ;; Show tab completion options instead of just choosing one
  ;; (setq eshell-cmpl-cycle-completions nil)
  (add-hook
   'eshell-mode-hook
   (lambda ()
     ;; For some reason eshell input uses this face
     (face-remap-add-relative
      'markdown-inline-code-face '(:foreground "white"))
     ;; Disable whitespace
     (face-remap-add-relative 'nobreak-space '(:background nil))
     ;; (face-remap-add-relative 'trailing-whitespace '(:background nil))
     ;; (setq nobreak-space 'override-nobreak-space)
     (whitespace-mode 0)

     ;; Bindings
     (define-key eshell-mode-map (kbd "C-u") 'eshell-kill-input)
     (define-key eshell-mode-map (kbd "C-c u") 'rk/eshell-kill-last-output)
     )
   )
  )

(defun egit-save ()
  "`egit' save"
  (interactive)
  (if (= (call-process "~/.bin/egit" nil nil nil "-p") 0)
      (progn
        (shell-command-to-string "~/.bin/sgitt_auto")
        )
    (eshell/cd (shell-command-to-string "~/.bin/egit -n | tr -d '\n'"))
    )
  )

;; This works to add abbreviations but probably shouldn't use this because it
;; doesn't enforce the abbreviations are only used at the start of the line? For
;; the command
;; (progn
;;   (when (boundp 'eshell-mode-abbrev-table)
;;     (clear-abbrev-table eshell-mode-abbrev-table))
;;   (define-abbrev-table 'eshell-mode-abbrev-table
;;     '(
;;       ("gsmuirr" "git submodule update --init --recursive --remote")
;;       )
;;     ))

(defun rk/eshell-interactive-output-readonly ()
  "Make output of interactive commands in eshell read-only.
This should be the last entry in eshell-output-filter-functions!"
  (let ((end eshell-last-output-end))
    (save-excursion
      (goto-char end)
      (end-of-line 0)
      (setq end (point)))
    (when (< eshell-last-output-block-begin end)
      (put-text-property eshell-last-output-block-begin end 'read-only "Read-only interactive eshell output"))))

(defun rk/eshell-make-interactive-output-readonly ()
  (add-hook 'eshell-output-filter-functions 'rk/eshell-interactive-output-readonly 'append))

(add-hook 'eshell-mode-hook 'rk/eshell-make-interactive-output-readonly)

(defun rk/eshell-kill-last-output ()
  "Kill the output."
  (interactive)
  (kill-ring-save (eshell-beginning-of-output) (eshell-end-of-output))
  )

;; Problem with these is that out of last command starts before processing

;; (defun rk/eshell-last-output-to-diff-buffer ()
;;   "Diff buffer with output of last command."
;;   (interactive)
;;   (kill-ring-save (eshell-beginning-of-output) (eshell-end-of-output))
;;   (yank-to-diff-buffer)
;;   )

;; (defun rk/eshell-last-output-to-grep-buffer ()
;;   "Grep buffer with output of last command."
;;   (interactive)
;;   (kill-ring-save (eshell-beginning-of-output) (eshell-end-of-output))
;;   (yank-to-grep-buffer)
;;   )

;; (defun rk/eshell-last-output-to-dired-virtual-buffer ()
;;   "Virtual dired buffer with output of last command."
;;   (interactive)
;;   (kill-ring-save (eshell-beginning-of-output) (eshell-end-of-output))
;;   (yank-to-virtual-dired-buffer)
;;   )

(provide 'robenkleene-eshell)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-eshell.el ends here
