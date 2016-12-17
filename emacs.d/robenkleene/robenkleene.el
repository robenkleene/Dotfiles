;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

(defvar use-package-verbose t)

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(require 'robenkleene-bindings)
(require 'robenkleene-config)
(require 'robenkleene-functions)
(require 'robenkleene-dired)
(if window-system
    (require 'robenkleene-gui)
  (require 'robenkleene-terminal))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(require 'robenkleene-aggressive-indent)
(require 'robenkleene-better-defaults)
(require 'robenkleene-company)
(require 'robenkleene-editorconfig)
(require 'robenkleene-flycheck)
;; Disabling this for now beacuse I don't like how the window moves to add and remove the frame
;; (require 'robenkleene-git-gutter)
(require 'robenkleene-ido-ubiquitous)
(require 'robenkleene-magit)
(require 'robenkleene-pbcopy)
(require 'robenkleene-evil)
(require 'robenkleene-projectile)
(require 'robenkleene-rainbow-delimiters)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-smartparens)
(require 'robenkleene-smex)
;; Switching back to helm for now because `swiper' doesn't handle long lines in
;; terminal nicely
;; (require 'robenkleene-swiper)
(require 'robenkleene-helm-ag)
(require 'robenkleene-helm-swoop)
(require 'robenkleene-helm)

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
(require 'robenkleene-markdown)

;;; robenkleene.el ends here
