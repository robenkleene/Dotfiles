;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

;; Build a `.terminfo' that will support colors and underline at the same time
;; in `tmux': `{ infocmp -x screen-256color; printf '\t%s\n' 'ncv@,'; } > /tmp/t
;; && tic -x /tmp/t'

;; Setting `file-name-handler-alist' to nil reduces the number of regular
;; expressions that need to run when files are opened, this reduces startup time
;; by about 0.1s
(let ((file-name-handler-alist nil))
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
  (require 'robenkleene-bindings)
  (require 'robenkleene-completion)
  (require 'robenkleene-config)
  (require 'robenkleene-search)
  (require 'robenkleene-spelling)
  (require 'robenkleene-troubleshooting)
  (require 'robenkleene-window-management)

  (if window-system
      (progn
        (require 'robenkleene-gui)
        (require 'robenkleene-mac)
        )
    (require 'robenkleene-terminal))

  ;; Modes
  (require 'robenkleene-dired)
  (require 'robenkleene-eshell)
  (require 'robenkleene-modus)
  (require 'robenkleene-outline)
  (require 'robenkleene-shell)
  (require 'robenkleene-vc)

  ;; Packages
  (require 'robenkleene-adaptive-wrap)
  (require 'robenkleene-aggressive-indent)
  (require 'robenkleene-cape)
  (require 'robenkleene-diminish)
  (require 'robenkleene-editorconfig)
  (require 'robenkleene-eglot)
  (require 'robenkleene-magit)
  (require 'robenkleene-page-break-lines)
  (require 'robenkleene-smartparens)
  (require 'robenkleene-vertico)
  (require 'robenkleene-wgrep)
  (require 'robenkleene-yasnippet)

  ;; Languages
  (require 'robenkleene-csv)
  (require 'robenkleene-jade)
  (require 'robenkleene-kotlin)
  (require 'robenkleene-languages)
  (require 'robenkleene-lua)
  (require 'robenkleene-markdown)
  (require 'robenkleene-org)
  (require 'robenkleene-prog)
  (require 'robenkleene-rust)
  (require 'robenkleene-swift)
  (require 'robenkleene-text)
  (require 'robenkleene-typescript)
  (require 'robenkleene-yaml)
  )


(provide 'robenkleene)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene.el ends here
