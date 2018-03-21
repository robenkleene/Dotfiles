;;; robenkleene-evil-dired.el --- robenkleene-evil-dired
;;; Commentary:
;;; Code:


(with-eval-after-load 'dired
  (defun robenkleene-dired-toggle-omit-mode ()
    "Toggle `dired-omit-mode'"
    (interactive)
    (if dired-omit-mode
        (dired-omit-mode 0)
      (dired-omit-mode 1)
      )
    )
  (evil-define-key 'motion dired-mode-map (kbd "gh") 'robenkleene-dired-toggle-omit-mode)
  )

(provide 'robenkleene-evil-dired)
;;; robenkleene-evil-dired.el ends here
