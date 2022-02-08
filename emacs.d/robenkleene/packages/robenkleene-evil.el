;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package evil
  :commands (turn-on-evil-mode turn-off-evil-mode)
  :bind
  ("C-c v" . robenkleene/toggle-evil)
  :init
  ;; (setq evil-toggle-key "")
  (defun robenkleene/toggle-evil ()
    (interactive)
    (if (bound-and-true-p evil-mode)
        (turn-off-evil-mode)
      (turn-on-evil-mode)
      ))
  :config
  ;; (define-key evil-normal-state-map "\C-c/" nil)
  (define-key evil-normal-state-map (kbd "C-c v") 'robenkleene/toggle-evil)
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
