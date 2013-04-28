;; Startup

;; Package Providers
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Start the emacs server if it isn't already running
(require 'server)
(unless (server-running-p)
  (server-start))

;; Load Basic Settings
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene"))
(require 'rk-settings)
(require 'rk-functions)
(require 'rk-keybindings)
(require 'rk-theme)

;; Load Feature Settings
(require 'rk-features)
(require 'rk-features-packages)

;; Load Mode Settings
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/modes"))
(require 'rk-ediff)
(require 'rk-org)
(require 'rk-markdown)
(require 'rk-parenedit)
(require 'rk-magit)
;; Lisp
(require 'rk-geiser)
;; Setup quicklisp instead
;; (require 'rk-slime)
(require 'rk-emacs-lisp)

