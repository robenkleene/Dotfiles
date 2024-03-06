;;; robenkleene-embark.el --- robenkleene-embark
;;; Commentary:
;;; Code:

(use-package embark
  :bind
  (
   ("C-c e" . embark-act)
   ("C-h B" . embark-bindings))
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
