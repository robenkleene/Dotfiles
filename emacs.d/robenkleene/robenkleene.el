;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

(defvar use-package-verbose t)

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark t)
(if window-system
    (load-theme 'wombat))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(require 'robenkleene-bindings)
(require 'robenkleene-emacs)
(require 'robenkleene-functions)
(require 'robenkleene-dired)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(require 'robenkleene-aggressive-indent)
(require 'robenkleene-better-defaults)
(require 'robenkleene-company)
(require 'robenkleene-editorconfig)
(require 'robenkleene-flycheck)
(require 'robenkleene-git-gutter)
(require 'robenkleene-magit)
(require 'robenkleene-pbcopy)
(require 'robenkleene-projectile)
(require 'robenkleene-rainbow-delimiters)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-smartparens)

;; `fill-column-indicator' is not compatible with `show-trailing-whitespace'
;; Font lock errors on startup are from `fill-column-indicator'
(require 'robenkleene-fill-column-indicator)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/languages"))
(require 'robenkleene-common-lisp)
(require 'robenkleene-emacs-lisp)
(require 'robenkleene-jade)
(require 'robenkleene-javascript)
(require 'robenkleene-ruby)
(require 'robenkleene-swift)

;;; robenkleene.el ends here
