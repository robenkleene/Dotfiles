;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

;; Build a `.terminfo' that will support colors and underline at the same time
;; in `tmux': `{ infocmp -x screen-256color; printf '\t%s\n' 'ncv@,'; } > /tmp/t
;; && tic -x /tmp/t'

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(if (file-exists-p "~/.emacs_local.el")
    (load-file "~/.emacs_local.el")
  )

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(require 'robenkleene-config)
(require 'robenkleene-functions)
(require 'robenkleene-ido)
(require 'robenkleene-bindings)
(require 'robenkleene-alias)
(require 'robenkleene-dired)
(require 'robenkleene-eshell)
(if window-system
    (progn
      (require 'robenkleene-gui)
      (require 'robenkleene-mac)
      )
  (require 'robenkleene-terminal))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(require 'robenkleene-aggressive-indent)
(require 'robenkleene-editorconfig)
(require 'robenkleene-yasnippet)
(require 'robenkleene-magit)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-smartparens)
(require 'robenkleene-wgrep)
(require 'robenkleene-helm)
(require 'robenkleene-eglot)
(require 'robenkleene-autothemer)
(require 'robenkleene-page-break-lines)
(require 'robenkleene-expand-region)
(require 'robenkleene-adaptive-wrap)
(require 'robenkleene-vundo)
(require 'robenkleene-evil)
;; (require 'robenkleene-smex)
(require 'robenkleene-vertico)

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
;; (load-theme 'kleene-dark t)
;; If this theme seems broken, check the `COLORTERM' shell environment variable
;; is set
;; (load-theme 'catppuccin-mocha t)
(require 'robenkleene-modus)
;; (require 'robenkleene-ef-themes)
(require 'robenkleene-override-theme)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/languages"))
(require 'robenkleene-languages)
(require 'robenkleene-common-lisp)
(require 'robenkleene-emacs-lisp)
(require 'robenkleene-jade)
(require 'robenkleene-ruby)
(require 'robenkleene-swift)
(require 'robenkleene-markdown)
(require 'robenkleene-fish)
(require 'robenkleene-ledger)
(require 'robenkleene-csv)
(require 'robenkleene-bash)
(require 'robenkleene-css)
(require 'robenkleene-objective-c)
(require 'robenkleene-git-commit)
(require 'robenkleene-rust)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene.el ends here
