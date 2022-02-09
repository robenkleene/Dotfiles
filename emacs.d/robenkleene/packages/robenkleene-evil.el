;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package evil
  :commands (evil-mode)
  :bind
  ("C-c v" . evil-mode)
  ("C-c C-v" . evil-mode)
  (:map robenkleene/leader-map
        ("[" . evil-mode)
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
  (if (display-graphic-p)
      (add-hook 'evil-mode-hook
                (lambda ()
                  (unless evil-mode
                    (message "Emacs")
                    (robenkleene/evil-fix-cursor)
                    )
                  (if evil-mode (message "Evil"))
                  )
                )
    )
  (defun robenkleene/evil-fix-cursor ()
    (interactive)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (kill-local-variable 'cursor-type))))
  :config
  (with-eval-after-load 'evil-maps
    (define-key evil-normal-state-map (kbd "C-c v") 'evil-mode)
    (define-key evil-normal-state-map (kbd "C-c C-v") 'evil-mode)
    (define-key evil-normal-state-map (kbd "M-a") robenkleene/leader-map)
    (define-key evil-normal-state-map (kbd "q") 'evil-mode)
    )
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

  (unless (display-graphic-p)
    (use-package evil-terminal-cursor-changer
      :config
      (evil-terminal-cursor-changer-activate)
      (setq evil-motion-state-cursor 'box)
      (setq evil-visual-state-cursor 'box)
      (setq evil-normal-state-cursor 'box)
      (setq evil-insert-state-cursor 'bar)
      (setq evil-emacs-state-cursor  'hbar)
      )
    )
  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here
