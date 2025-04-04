(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ))
(package-initialize)

(package-autoremove)

;; Do upgrade first because this also does a refresh
(package-upgrade-all)

(dolist (package package-selected-packages)
  (package-install package))
