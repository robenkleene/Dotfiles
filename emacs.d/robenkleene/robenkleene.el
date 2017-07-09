;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

;; Build a `.terminfo' that will support colors and underline at the same time
;; in `tmux':
;; `{ infocmp -x screen-256color; printf '\t%s\n' 'ncv@,'; } > /tmp/t && tic -x /tmp/t'
(defvar use-package-verbose t)

(setq-default flycheck-emacs-lisp-load-path 'inherit)

;; Load `evil' early to other packages can bind to its maps
;; This must come before `dired' for example, in order to disable `evil'
;; integrations.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/evil"))
(require 'robenkleene-evil)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(require 'robenkleene-config)
(require 'robenkleene-functions)
(require 'robenkleene-dired)
(if window-system
    (require 'robenkleene-gui)
  (require 'robenkleene-terminal))


(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
;; Dependencies
;; It's important to load these early
(require 'robenkleene-bind-map)

;; Packages
(require 'robenkleene-aggressive-indent)
(require 'robenkleene-better-defaults)
;; Temporarily removing this because it's annoying
;; (require 'robenkleene-company)
(require 'robenkleene-editorconfig)
(require 'robenkleene-flycheck)
;; Disabling this for now because I don't like how the window moves to add and remove the frame
;; (require 'robenkleene-git-gutter)
(require 'robenkleene-ido-completing-read)
(require 'robenkleene-yasnippet)
(require 'robenkleene-magit)
(require 'robenkleene-pbcopy)
(require 'robenkleene-projectile)
(require 'robenkleene-rainbow-delimiters)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-smartparens)
(require 'robenkleene-smex)
(require 'robenkleene-fasd)
(require 'robenkleene-helm)
(require 'robenkleene-buffer-move)
(require 'robenkleene-wgrep)
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
(require 'robenkleene-fish)

;;; robenkleene.el ends here
