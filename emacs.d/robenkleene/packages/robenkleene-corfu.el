;;; robenkleene-corfu.el --- robenkleene-corfu
;;; Commentary:
;;; Code:

;; Use corfu because `yasnippt' suport for `hippie-expand' isn't working
(use-package corfu
  :init
  (use-package cape
    :init
    (add-to-list 'completion-at-point-functions #'cape-file)
    (use-package company
      :after cape
      :init
      ;; Adding here way doesn't work in `prog-mode', but it does work for `text-mode'
      (add-to-list 'completion-at-point-functions (cape-company-to-capf #'company-yasnippet))
      )
    ;; Try this after git support is added to `use-package' in Emacs 29
    ;; (use-package cape-yasnippet
    ;;   :init
    ;;   (add-to-list 'completion-at-point-functions 'cape-yasnippet)
    ;;   )
    )

  (use-package corfu-terminal)
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)
    )

  ;; Languages
  (add-hook 'prog-mode-hook (lambda ()
                              ;; This helps complete Emacs symbols that aren't
                              ;; loaded yet (E.g., the name of a WIP function)
                              (setq-local completion-at-point-functions
                                          (cons #'cape-dabbrev
                                                completion-at-point-functions))
                              (add-to-list 'completion-at-point-functions #'cape-file)
                              ;; This should already be in `completion-at-point-functions' but for some reason we have to add it twice to `prog-mode'
                              (add-to-list 'completion-at-point-functions (cape-company-to-capf #'company-yasnippet))
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
