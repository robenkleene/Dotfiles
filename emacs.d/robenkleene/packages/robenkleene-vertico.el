;;; robenkleene-vertico.el --- robenkleene-vertico
;;; Commentary:
;;; Code:

(use-package vertico
  :bind
  (:map vertico-map
        ;; Display possible completions (like `<tab>` for default interface)
        ("?" . 'minibuffer-completion-help)
        ;; The default has `<tab>' for `vertico-insert' and `M-<tab>' for
        ;; `minibuffer-complete'. Swapping these seems more natural because it
        ;; allows using `<tab>' to complete the longest common string (`M-<tab>'
        ;; then completes the full selected item without exiting)
        ("<tab>" . 'minibuffer-complete)
        ("M-<tab>" . 'vertico-insert)
        ("TAB" . 'minibuffer-complete)
        ("M-TAB" . 'vertico-insert)
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
         ;; Use `consult-buffer' because it supports `recentf' by default (hit
         ;; `f<space>')
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ;; This has find-as-you-type, but also doesn't need the odd `*rescan*'
         ;; item
         ("M-g i" . consult-imenu)
         ;; Don't add `consult-occur' or `consult-grep', etc... instead for
         ;; anything that generates a `compile' buffer, just use the regular
         ;; compile buffer commands to traverse matches (e.g., `M-g n')
         )
  )

;; Orderless makes regular fuzzy matching work, without it a search for a
;; filename will have to start with the start of that filename
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'robenkleene-vertico)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vertico.el ends here
