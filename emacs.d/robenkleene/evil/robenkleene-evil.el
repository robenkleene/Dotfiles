;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package evil
  :ensure t
  :config
  ;; Disable insert mode key map
  (setcdr evil-insert-state-map nil)
  ;; Re-enable Esc
  (define-key evil-insert-state-map [escape] 'evil-normal-state)

  (require 'robenkleene-evil-motion-state-map)
  (require 'robenkleene-evil-unimpaired-map)
  (require 'robenkleene-evil-leader-map)
  (require 'robenkleene-evil-dired)

  (evil-mode 1)
  )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here


