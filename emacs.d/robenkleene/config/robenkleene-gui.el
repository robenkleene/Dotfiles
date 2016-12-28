;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

(add-to-list 'custom-theme-load-path "~/.emacs.d/robenkleene/themes/")
(load-theme 'kleene-dark3 t)
(set-face-background 'default "#232323")

(add-to-list 'default-frame-alist '(cursor-color . "#4BC840"))
(setq mac-command-modifier 'control)
(setq mac-option-modifier 'meta)

(provide 'robenkleene-gui)
;;; robenkleene-gui.el ends here
