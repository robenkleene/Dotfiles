(require 'package)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(setq package-enable-at-startup nil)
(setq package-archives '(
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile
    (unless (bound-and-true-p package--initialized)
      (package-initialize))
    (require 'use-package)))
(setq use-package-always-ensure t)
(dolist (package package-selected-packages)
  (use-package package))
(package-upgrade-all)
(package-autoremove)