;;; robenkleene-vertico.el --- robenkleene-vertico
;;; Commentary:
;;; Code:

(use-package vertico
  :bind
  (:map vertico-map
        ;; Display possible completions (like `<tab>` for default interface)
        ("?" . 'minibuffer-completion-help)
        )
  :init
  (vertico-mode)
  )

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode)
  )

(use-package consult
  :bind (
         ;; Use `consult-buffer' because it supports `recentf' by defalt (hit
         ;; `f<space>')
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ;; This has find-as-you-type, but also doesn't need the odd `*rescan*'
         ;; item
         ("M-g i" . consult-imenu)
         )
  )

(provide 'robenkleene-vertico)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vertico.el ends here
