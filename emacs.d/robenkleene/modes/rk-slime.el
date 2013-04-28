(provide 'rk-slime)

;; Setup quicklisp instead

;; SLIME
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-to-list 'load-path "~/.emacs.d/manual/slime-2013-04-05") ;; Installed manually package install failed
(require 'slime)
;; (slime-setup)
(slime-setup '(slime-fancy))
