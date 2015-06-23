(add-to-list 'load-path (expand-file-name "~/.spacemacs.d/config"))
(require 'robenkleene-config)
(require 'robenkleene-keybindings)
(require 'robenkleene-theme)

(add-to-list 'load-path (expand-file-name "~/.spacemacs.d/config/packages"))
(require 'robenkleene-dired)
(require 'robenkleene-evil)
