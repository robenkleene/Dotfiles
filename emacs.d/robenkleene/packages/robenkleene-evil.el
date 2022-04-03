;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package evil
  :commands (evil-mode)
  :bind
  (:map robenkleene/leader-map
        ("[" . evil-mode)
        ("j" . evil-mode)
        ("/" . (lambda ()
                 (interactive)
                 (evil-mode)
                 (evil-search-forward)))
        ("?" . (lambda ()
                 (interactive)
                 (evil-mode)
                 (evil-search-backward)))
        )
  :init
  ;; (setq evil-toggle-key "")
  ;; hl-line in normal mode & cursor fix
  (add-hook 'evil-mode-hook
            (lambda ()
              (unless evil-mode
                (message "Emacs")
                (if (display-graphic-p)
                    (robenkleene/evil-fix-cursor)
                  )
                )
              (if evil-mode
                  (progn
                    (if (eq evil-state 'normal)
                        (hl-line-mode +1)
                      )
                    (message "Evil")
                    )
                )
              )
            )
  (add-hook 'evil-normal-state-entry-hook (lambda() (hl-line-mode +1)))
  (add-hook 'evil-normal-state-exit-hook (lambda() (hl-line-mode -1)))

  (defun robenkleene/evil-fix-cursor ()
    (interactive)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (kill-local-variable 'cursor-type))))
  (setq evil-disable-insert-state-bindings t)
  ;; (setq evil-default-state 'insert)
  (add-hook 'text-mode-hook 'evil-mode)
  (add-hook 'prog-mode-hook 'evil-mode)
  :config
  ;; Cursor gets stuck using this
  ;; (unless (display-graphic-p)
  ;;   (use-package evil-terminal-cursor-changer
  ;;     :config
  ;;     (evil-terminal-cursor-changer-activate)
  ;;     (setq evil-motion-state-cursor 'box)
  ;;     (setq evil-visual-state-cursor 'box)
  ;;     (setq evil-normal-state-cursor 'box)
  ;;     (setq evil-insert-state-cursor 'bar)
  ;;     (setq evil-emacs-state-cursor  'hbar)
  ;;     )
  ;;   )

  ;; Bindings
  (with-eval-after-load 'evil-maps
    (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
    (define-key evil-normal-state-map (kbd "M-a") robenkleene/leader-map)
    (define-key evil-normal-state-map (kbd "<escape>") 'evil-insert)
    ;; (define-key evil-normal-state-map (kbd "q") 'evil-mode)
    )

  ;; Packages
  (use-package evil-visualstar
    :commands (evil-visualstar/begin-search-forward
               evil-visualstar/begin-search-backward)
    :init
    (progn
      (define-key evil-visual-state-map (kbd "*")
        'evil-visualstar/begin-search-forward)
      (define-key evil-visual-state-map (kbd "#")
        'evil-visualstar/begin-search-backward)))
  (use-package evil-surround
    :init
    (global-evil-surround-mode 1))
  (use-package evil-goggles
    :ensure t
    :config
    (evil-goggles-mode))
  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here
