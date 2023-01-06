;;; robenkleene-vterm.el --- robenkleene-vterm
;;; Commentary:
;;; Code:

(use-package vterm
  :commands
  (vterm vterm-other-window)
  :init
  (setq vterm-shell "/usr/local/bin/fish")
  :config
  ;; (make-variable-buffer-local 'nobreak-space)
  ;; (copy-face 'nobreak-space 'override-nobreak-space)
  ;; (set-face-background 'override-nobreak-space nil)
  (add-hook 'vterm-mode-hook
            (lambda ()
              (face-remap-add-relative 'nobreak-space '(:background nil))
              (face-remap-add-relative 'trailing-whitespace '(:background nil))
              ;; (setq nobreak-space 'override-nobreak-space)
              (whitespace-mode 0)
              ))
  )

(provide 'robenkleene-vterm)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vterm.el ends here
