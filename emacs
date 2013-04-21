; -*-Emacs-Lisp-*-

;; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives 
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Auto Save Files
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;; Smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; Slime
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-to-list 'load-path ".emacs.d/manual/slime-2013-04-05") ;; Installed manually package install failed
(require 'slime)
;; (slime-setup)
(slime-setup '(slime-fancy))

;; Start the emacs server if it isn't already running
(require 'server)
(unless (server-running-p)
  (server-start))

;; Disable Toolbar
(tool-bar-mode -1)

;; ido mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; All the beeping is annoying
(setq visible-bell 1)

;; Theme
(load-theme 'wombat)
(global-hl-line-mode t)

;; Geiser
(setq geiser-active-implementations '(racket))
(setq geiser-racket-binary "/usr/local/bin/racket")
