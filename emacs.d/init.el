;;; init.el --- init
;;; Commentary:
;;; Code:

;; Help prevent trying to compile the entire home directory on Emacs startup
(cd "~/.emacs.d")

(require 'package)
;; (setq package-enable-at-startup nil)
;; (setq package-archives '(
;;                          ("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
;;                          ("melpa" . "http://melpa.org/packages/")
;;                          ))
(package-initialize)

;; Use Emacs install script instead
;; Bootstrap `use-package'
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package)
;;   (eval-when-compile
;;     (unless (bound-and-true-p package--initialized)
;;       (package-initialize))
;;     (require 'use-package)))
;; Install packages
;; (setq use-package-always-ensure t)

;; `use-package' requires `bind-key'
;; (use-package bind-key
;;   :ensure t
;;   :config
;;   (add-to-list 'same-window-buffer-names "*Personal Keybindings*"))

;; (defvar use-package-verbose t)

;; Without this, using `package.el` will add this content to this file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Suppresses annoying message:
;; `ad-handle-definition: ‘ido-completing-read’ got redefined'
(set 'ad-redefinition-action 'accept)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene"))

(require 'robenkleene)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; init.el ends here
