;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

(require 'use-package)

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'robenkleene-dark t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(require 'robenkleene-emacs)
(require 'robenkleene-functions)
(require 'robenkleene-dired)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(require 'robenkleene-evil)
(require 'robenkleene-flycheck)
(require 'robenkleene-smartparens)
(require 'robenkleene-helm)
(require 'robenkleene-helm-swoop)
(require 'robenkleene-pbcopy)
(require 'robenkleene-magit)

;;; robenkleene.el ends here


