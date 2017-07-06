;;; robenkleene-evil-dired.el --- robenkleene-evil-dired
;;; Commentary:
;;; Code:

(eval-after-load 'dired
  '(progn
     ;; Search behaves more practicably with symlinks visible
     (defvar dired-mode-map)
     (define-key dired-mode-map (kbd "-") 'dired-up-directory)
     ))

(provide 'robenkleene-evil-dired)
;;; robenkleene-evil-dired.el ends here
