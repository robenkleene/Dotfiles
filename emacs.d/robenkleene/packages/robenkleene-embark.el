;;; robenkleene-embark.el --- robenkleene-embark
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package embark
  :bind
  (
   ;; Doesn't work in terminal
   ;; ("C-." . embark-act)         ;; pick some comfortable binding
   ("C-c ." . embark-act)         ;; pick some comfortable binding
   ("C-c ;" . embark-dwim)         ;; pick some comfortable binding
   ;; Doesn't work in terminal
   ;; ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  ;; (:map minibuffer-mode-map
  ;;       ("M-." . embark-act)
  ;;       )
  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  (defun embark-reveal-in-finder (file)
    "Reveal `file' in finder."
    (interactive "GFile: ")
    (shell-command (concat "open -R "
                           (shell-quote-argument file))
                   )
    )
  (define-key embark-file-map "M-r" #'embark-reveal-in-finder)
  (define-key embark-region-map "M-r" #'embark-reveal-in-finder)

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))

  ;; ;; Use completion instead of keyboard shortcuts
  ;; (setq embark-prompter #'embark-completing-read-prompter)
  ;; ;; Don't show the completion pop-up
  (setq embark-indicators '(embark-minimal-indicator))

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
