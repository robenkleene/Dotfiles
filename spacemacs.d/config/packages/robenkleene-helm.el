(eval-after-load 'helm-swoop
   '(progn
      (define-key helm-swoop-map (kbd "C-w") 'backward-kill-word)
     ))
(provide 'robenkleene-helm)
