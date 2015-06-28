;;; robenkleene-ui.el --- robenkleene-ui
;;; Commentary:
;;; Code:

(global-linum-mode t)
(add-hook 'dired-mode-hook
          (lambda ()
            (linum-mode 0)))
(add-hook 'magit-mode-hook
          (lambda ()
            (linum-mode 0)))

(provide 'robenkleene-ui)
;;; robenkleene-ui.el ends here
