;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package evil
  :ensure t
  :init
  (setq evil-toggle-key "")
  :config

  ;; Other Evil Packages
  (use-package evil-commentary
    :ensure t
    :config (evil-commentary-mode))
  (use-package evil-smartparens
    :ensure t
    :config
    (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
    )
  (use-package evil-visualstar
    :ensure t
    :commands (evil-visualstar/begin-search-forward
               evil-visualstar/begin-search-backward)
    :init
    (progn
      (define-key evil-normal-state-map (kbd "gx") 'browse-url-at-point)
      (define-key evil-visual-state-map (kbd "*") 'evil-visualstar/begin-search-forward)
      (define-key evil-visual-state-map (kbd "#") 'evil-visualstar/begin-search-backward)))
  (use-package evil-surround
    :ensure t 
    :init
    (global-evil-surround-mode 1))

  (unless (display-graphic-p)
    (use-package evil-terminal-cursor-changer
      :ensure t
      :config
      (evil-terminal-cursor-changer-activate)
      (setq evil-motion-state-cursor 'box)
      (setq evil-visual-state-cursor 'box)
      (setq evil-normal-state-cursor 'box)
      (setq evil-insert-state-cursor 'bar)
      (setq evil-emacs-state-cursor  'hbar)
      )
    )
  
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/evil/config"))
  ;; Maps  
  (require 'robenkleene-evil-maps)
  ;; Settings
  (require 'robenkleene-evil-modes)
  (require 'robenkleene-evil-settings)

  ;; Languages
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/evil/languages"))
  (require 'robenkleene-evil-emacs-lisp)

  ;; Activate
  (evil-mode 1)

  )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here
