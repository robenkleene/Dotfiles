;;; robenkleene-vertico.el --- robenkleene-vertico
;;; Commentary:
;;; Code:

(use-package vertico
  :bind
  (:map vertico-map
        ;; ;; Display possible completions (like `<tab>` for default interface)
        ;; ("?" . 'minibuffer-completion-help)

        ;; Swapped Tab
        ;; The default has `<tab>' for `vertico-insert' and `M-<tab>' for
        ;; `minibuffer-complete'. Swapping these seems more natural because it
        ;; allows using `<tab>' to complete the longest common string (`M-<tab>'
        ;; then completes the full selected item without exiting)
        ;; ("TAB" . 'minibuffer-complete)
        ;; ("<tab>" . 'minibuffer-complete)
        ;; ;; `vertico-insert' inserts the current completion entry
        ;; ("M-TAB" . 'vertico-insert)
        ;; ("M-<tab>" . 'vertico-insert)

        ;; Default Tab
        ("M-TAB" . 'minibuffer-complete)
        ("M-<tab>" . 'minibuffer-complete)
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
         ("C-x C-b" . consult-buffer)
         ("C-x 4 C-b" . consult-buffer-other-window)
         ("C-x 5 C-b" . consult-buffer-other-frame)
         ("C-x t C-b" . consult-buffer-other-tab)
         ;; This has find-as-you-type, but also doesn't need the odd `*rescan*'
         ;; item
         ("M-g M-i" . consult-imenu)
         ("M-s M-g" . consult-ripgrep)
         ("M-s M-f" . consult-fd)
         ("M-s M-o" . consult-line)
         )
  :init
  ;; Time to wait before updating results, the default is `0.2'
  ;; Decreasing this makes `consult' feel significantly more responsive
  (setq consult-async-input-debounce 0.05)
  )

;; Orderless makes regular fuzzy matching work, without it a search for a
;; filename will have to start with the start of that filename
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

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
  (use-package embark-consult
    :hook
    (embark-collect-mode . consult-preview-at-point-mode)
    )
)

(provide 'robenkleene-vertico)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-vertico.el ends here
