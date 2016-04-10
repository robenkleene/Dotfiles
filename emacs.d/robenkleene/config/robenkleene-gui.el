;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

;; (load-theme 'wombat)

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark t)
(set-face-background 'default "#232323")

(setq mac-command-modifier 'control)
(setq mac-option-modifier 'meta)

(provide 'robenkleene-gui)
;;; robenkleene-gui.el ends here
