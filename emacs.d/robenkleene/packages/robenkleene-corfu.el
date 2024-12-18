;;; robenkleene-corfu.el --- robenkleene-corfu
;;; Commentary:
;;; Code:

(use-package corfu
  :init
  (use-package corfu-terminal)
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)
    )

  ;; Languages
  (add-hook 'prog-mode-hook (lambda ()
                              (corfu-mode)
                              ))
  ;; For completing relative paths
  (add-hook 'text-mode-hook (lambda ()
                              (corfu-mode)
                              ))

  ;; Enable in minibuffer
  ;; (defun corfu-enable-in-minibuffer ()
  ;;   "Enable Corfu in the minibuffer."
  ;;   (when (local-variable-p 'completion-at-point-functions)
  ;;     ;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
  ;;     (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
  ;;                 corfu-popupinfo-delay nil)
  ;;     (corfu-mode 1)))
  ;; (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)
  :config
  (setq corfu-auto t)
  )

(provide 'robenkleene-corfu)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-corfu.el ends here
