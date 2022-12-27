;;; init.el --- init
;;; Commentary:
;;; Code:

;; Byte compile init files
;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (load "~/.emacs.d/init-use-package.el")
  )

(setq use-package-always-ensure t)
;; `use-package' requires `bind-key'
(use-package bind-key
  :ensure t
  :config
  (add-to-list 'same-window-buffer-names "*Personal Keybindings*"))

;; (defvar use-package-verbose t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Suppresses annoying message:
;; `ad-handle-definition: ‘ido-completing-read’ got redefined'
(set 'ad-redefinition-action 'accept)

(eval-and-compile
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene"))
  )
(require 'robenkleene)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; init.el ends here
