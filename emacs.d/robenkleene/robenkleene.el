;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

;; Build a `.terminfo' that will support colors and underline at the same time
;; in `tmux':
;; `{ infocmp -x screen-256color; printf '\t%s\n' 'ncv@,'; } > /tmp/t && tic -x /tmp/t'

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(require 'robenkleene-config)
(require 'robenkleene-functions)
(require 'robenkleene-ido)
(require 'robenkleene-bindings)
(require 'robenkleene-alias)
(require 'robenkleene-dired)
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
(require 'robenkleene-pbcopy)
(require 'robenkleene-rainbow-delimiters)
(require 'robenkleene-rainbow-mode)
(require 'robenkleene-smartparens)
(require 'robenkleene-smex)
(require 'robenkleene-macrostep)
(require 'robenkleene-ivy)
(require 'robenkleene-wgrep)
(require 'robenkleene-page-break-lines)
(require 'robenkleene-fill-column-indicator)
;; This breaks default undo via `C-g C-_'
(require 'robenkleene-undo-tree)
(require 'robenkleene-iedit)
(require 'robenkleene-anzu)

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

;;; robenkleene.el ends here
