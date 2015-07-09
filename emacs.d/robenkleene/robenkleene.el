;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

(defvar use-package-verbose t)

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'robenkleene-dark t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(require 'robenkleene-emacs)
(require 'robenkleene-functions)
(require 'robenkleene-dired)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/evil"))
(require 'robenkleene-evil-functions)
(require 'robenkleene-evil)
(require 'robenkleene-evil-commentary)
(require 'robenkleene-evil-tabs)
(require 'robenkleene-evil-magit)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(require 'robenkleene-better-defaults)
(require 'robenkleene-editorconfig)
(require 'robenkleene-rainbow-delimiters)
(require 'robenkleene-flycheck)
(require 'robenkleene-smartparens)
(require 'robenkleene-helm)
;; Evil Dired has to be loaded after helm for some reason
(require 'robenkleene-evil-dired)
(require 'robenkleene-helm-ag)
(require 'robenkleene-helm-swoop)
(require 'robenkleene-projectile)
(require 'robenkleene-company)
(require 'robenkleene-pbcopy)
(require 'robenkleene-magit)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-fill-column-indicator)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/languages"))
(require 'robenkleene-jade)
(require 'robenkleene-emacs-lisp)
(require 'robenkleene-javascript)
(require 'robenkleene-ruby)

;;; robenkleene.el ends here
