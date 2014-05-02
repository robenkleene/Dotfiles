;; Startup

;; Package Providers
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents) 
	(package-refresh-contents))

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
(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/languages"))
(require 'rk-emacs-lisp)
(require 'rk-scheme)
(require 'rk-git)
(require 'rk-markdown)
(require 'rk-clojure)
(require 'rk-org)
(require 'rk-ruby)
;; (require 'rk-common-lisp)
