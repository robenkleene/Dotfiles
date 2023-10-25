;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

;; Build a `.terminfo' that will support colors and underline at the same time
;; in `tmux': `{ infocmp -x screen-256color; printf '\t%s\n' 'ncv@,'; } > /tmp/t
;; && tic -x /tmp/t'

(if (file-exists-p "~/.emacs_local.el")
    (load-file "~/.emacs_local.el")
  )

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/modes"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/languages"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/functions"))

;; Functions
(require 'robenkleene-functions)
(require 'robenkleene-keymap)
(require 'robenkleene-interactive)
(require 'robenkleene-alias)

;; Config
(require 'robenkleene-config)
(require 'robenkleene-window-management)
(require 'robenkleene-search)
(require 'robenkleene-spelling)
(require 'robenkleene-ido)
(require 'robenkleene-bindings)
(if window-system
    (progn
      (require 'robenkleene-gui)
      (require 'robenkleene-mac)
      )
  (require 'robenkleene-terminal))
(require 'robenkleene-troubleshooting)

;; Modes
(require 'robenkleene-org)
(require 'robenkleene-compilation)
(require 'robenkleene-grep)
(require 'robenkleene-prog)
(require 'robenkleene-text)
(require 'robenkleene-dired)
(require 'robenkleene-ibuffer)
(require 'robenkleene-eshell)
(require 'robenkleene-shell)
(require 'robenkleene-diff)
(require 'robenkleene-vc)
(require 'robenkleene-ediff)

;; Packages
(require 'robenkleene-diminish)
(require 'robenkleene-smartparens)
(require 'robenkleene-aggressive-indent)
(require 'robenkleene-editorconfig)
(require 'robenkleene-page-break-lines)
(require 'robenkleene-adaptive-wrap)
(require 'robenkleene-yasnippet)
(require 'robenkleene-magit)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-wgrep)
(require 'robenkleene-eglot)
(require 'robenkleene-corfu)
(require 'robenkleene-iedit)

;; Completion
(require 'robenkleene-vertico)
(require 'robenkleene-orderless)
(require 'robenkleene-consult)
(require 'robenkleene-marginalia)

;; Eshell
(require 'robenkleene-eshell-syntax-highlighting)

;; Theme
(require 'robenkleene-modus)
(require 'robenkleene-ef-themes)
(require 'robenkleene-override-theme)

;; Languages
(require 'robenkleene-csv)
(require 'robenkleene-fish)
(require 'robenkleene-git-commit)
(require 'robenkleene-jade)
(require 'robenkleene-kotlin)
(require 'robenkleene-languages)
(require 'robenkleene-lua)
(require 'robenkleene-markdown)
(require 'robenkleene-rust)
(require 'robenkleene-swift)
(require 'robenkleene-typescript)

(provide 'robenkleene)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene.el ends here
