;;; init.el --- init
;;; Commentary:
;;; Code:

;; (setq package-enable-at-startup nil)

(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(load (concat user-emacs-directory "robenkleene/robenkleene.el"))
;;; init.el ends here


