;;; robenkleene.el --- Base Config
;;; Commentary:
;;; Code:


;; (setq flycheck-emacs-lisp-package-user-dir "~/.emacs.d/elpa")
(add-to-list 'load-path (expand-file-name "~/.spacemacs.d/config"))

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(require 'robenkleene-config)
(require 'robenkleene-keybindings)
(require 'robenkleene-theme)

(add-to-list 'load-path (expand-file-name "~/.spacemacs.d/config/packages"))
(require 'robenkleene-helm)
(require 'robenkleene-dired)
(require 'robenkleene-evil)
