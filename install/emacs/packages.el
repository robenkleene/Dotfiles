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

;;  This is built-in now
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package)
;;   (eval-when-compile
;;     (unless (bound-and-true-p package--initialized)
;;       (package-initialize))
;;     (require 'use-package)))
(package-autoremove)
;; Do upgrade early because this also does a refresh
(package-upgrade-all)
;; (setq use-package-always-ensure t)
(dolist (package package-selected-packages)
  (package-install package))
