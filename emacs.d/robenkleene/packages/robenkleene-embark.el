;;; robenkleene-embark.el --- robenkleene-embark
;;; Commentary:
;;; Code:

(use-package embark
  :bind
  (
   ("C-c e" . embark-act)
   ("C-h B" . embark-bindings))
  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  (defun embark-reveal-in-finder (file)
    "Reveal `file' in finder."
    (interactive "GFile: ")
    (if (file-exists-p file)
        (shell-command (concat "open -R "
                               (shell-quote-argument (expand-file-name file)))
                       )

      )
    )
  (define-key embark-file-map "R" #'embark-reveal-in-finder)
  (define-key embark-region-map "R" #'embark-reveal-in-finder)

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))

  ;; ;; Use completion instead of keyboard shortcuts
  ;; (setq embark-prompter #'embark-completing-read-prompter)
  ;; ;; Don't show the completion pop-up
  ;; (setq embark-indicators '(embark-minimal-indicator))

  ;; Consult users will also want the embark-consult package.
  (use-package embark-consult
    :ensure t ; only need to install it, embark loads it after consult if found
    :hook
    (embark-collect-mode . consult-preview-at-point-mode))
  )

(provide 'robenkleene-embark)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-embark.el ends here
