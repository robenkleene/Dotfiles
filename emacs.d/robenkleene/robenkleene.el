(require 'use-package)

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'robenkleene-dark t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene/packages"))
(require 'robenkleene-helm)
