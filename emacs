; -*-Emacs-Lisp-*-

(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;; Start the emacs server if it isn't already running
(require 'server)
(unless (server-running-p)
  (server-start))
