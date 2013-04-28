(provide 'rk-emacs-lisp)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (local-set-key (kbd "s-r") 'eval-buffer)))
(add-hook 'lisp-interaction-mode-hook
	  (lambda ()
	    (local-set-key (kbd "s-r") 'eval-buffer)))
