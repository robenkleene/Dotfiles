;;; robenkleene.el --- robenkleene
;;; Commentary:
;;; Code:

(if (file-exists-p "~/.emacs_local.el")
    (load-file "~/.emacs_local.el")
  )

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/config"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/modes"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/languages"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/functions"))

;; Functions
(require 'robenkleene-alias)
(require 'robenkleene-functions)
(require 'robenkleene-interactive)

;; Config
(require 'robenkleene-bindings)
(require 'robenkleene-completion)
(require 'robenkleene-config)
(require 'robenkleene-languages)
(require 'robenkleene-minibuffer)
(require 'robenkleene-shell-commands)
(require 'robenkleene-spelling)

(if window-system
    (progn
      (require 'robenkleene-gui)
      (require 'robenkleene-mac)
      )
  (require 'robenkleene-terminal))

;; Modes
(require 'robenkleene-diff)
(require 'robenkleene-dired)
(require 'robenkleene-eshell)
(require 'robenkleene-remember)
(require 'robenkleene-vc)

;; Packages
(require 'robenkleene-adaptive-wrap)
(require 'robenkleene-aggressive-indent)
(require 'robenkleene-diminish)
(require 'robenkleene-magit)
(require 'robenkleene-smartparens)
(require 'robenkleene-wgrep)

;; Languages
(require 'robenkleene-markdown)
(require 'robenkleene-prog)
(require 'robenkleene-text)

(provide 'robenkleene)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene.el ends here
