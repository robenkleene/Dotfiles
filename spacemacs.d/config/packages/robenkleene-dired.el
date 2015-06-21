(eval-after-load 'dired
   '(progn
      (define-key dired-mode-map (kbd "?") 'evil-search-backward)
      (define-key dired-mode-map (kbd "-") 'dired-up-directory) 
     ))

(add-hook 'dired-mode-hook 'dired-hide-details-mode) 

(provide 'robenkleene-dired)
