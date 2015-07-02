;;; robenkleene.el --- Base Config
;;; Commentary:
;;; Code:

(setq-default flycheck-emacs-lisp-load-path 'inherit)

;; Config
(add-to-list 'load-path (expand-file-name "~/.spacemacs.d/config"))
(require 'robenkleene-functions)
(require 'robenkleene-config)
(require 'robenkleene-keybindings)
(require 'robenkleene-spacemacs)
(require 'robenkleene-ui)


;; Packages
(add-to-list 'load-path (expand-file-name "~/.spacemacs.d/config/packages"))
(require 'robenkleene-helm)
(require 'robenkleene-magit)
(require 'robenkleene-dired)
(require 'robenkleene-evil)
(require 'robenkleene-smartparens)
(require 'robenkleene-evil-jumper)

;; Languages
(add-to-list 'load-path (expand-file-name "~/.spacemacs.d/config/languages"))
(require 'robenkleene-emacs-lisp)

;;; robenkleene.el ends here
