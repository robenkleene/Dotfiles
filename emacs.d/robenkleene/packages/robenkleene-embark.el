;;; robenkleene-embark.el --- robenkleene-embark
;;; Commentary:
;;; Code:

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
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))

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
