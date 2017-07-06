;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package evil
  :ensure t
  :config

  ;; Other Evil Packages
  (use-package evil-commentary
    :ensure t
    :config (evil-commentary-mode))

  (add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/evil/config"))
  ;; Settings
  (require 'robenkleene-evil-modes)
  (require 'robenkleene-evil-settings)
  ;; Maps  
  (require 'robenkleene-evil-motion-state-map)
  (require 'robenkleene-evil-unimpaired-map)
  (require 'robenkleene-evil-leader-map)

  ;; Packages
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/evil/packages"))
  (require 'robenkleene-evil-dired)

  ;; Languages
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/evil/languages"))
  (require 'robenkleene-evil-emacs-lisp)

  ;; Activate
  (evil-mode 1)
  )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here


