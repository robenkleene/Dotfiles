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
(require 'robenkleene-flycheck)
(require 'robenkleene-ido-completing-read)
(require 'robenkleene-yasnippet)
(require 'robenkleene-magit)
(require 'robenkleene-rainbow-delimiters)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-smartparens)
(require 'robenkleene-smex)
(require 'robenkleene-macrostep)
(require 'robenkleene-wgrep)
(require 'robenkleene-page-break-lines)
(require 'robenkleene-iedit)
(require 'robenkleene-anzu)
(require 'robenkleene-company)
(require 'robenkleene-literate-calc-mode)
(require 'robenkleene-imenu-list)
(require 'robenkleene-move-text)
(require 'robenkleene-flimenu)
(require 'robenkleene-super-save)
(require 'robenkleene-undo-tree)
(require 'robenkleene-diff-hl)
(require 'robenkleene-expand-region)
(require 'robenkleene-evil)
(require 'robenkleene-helm)
;; (require 'robenkleene-lsp)
(require 'robenkleene-eglot)
(require 'robenkleene-fasd)
(require 'robenkleene-autothemer)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/languages"))
(require 'robenkleene-languages)
(require 'robenkleene-common-lisp)
(require 'robenkleene-emacs-lisp)
(require 'robenkleene-jade)
(require 'robenkleene-javascript)
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
