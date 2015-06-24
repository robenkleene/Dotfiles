;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

(eval-after-load 'dired
   '(progn
      (defvar dired-mode-map)
      (define-key dired-mode-map (kbd "?") 'evil-search-backward)
      (define-key dired-mode-map (kbd "-") 'dired-up-directory)
     ))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(provide 'robenkleene-dired)

;;; robenkleene-dired.el ends here
