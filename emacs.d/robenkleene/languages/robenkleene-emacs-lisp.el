;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(eval-after-load "lisp-mode"
  '(progn
     ; (define-key robenkleene/emacs-lisp-eval-leader-map (kbd "b") (lambda ()
     ;                                                                (interactive)
     ;                                                                (eval-buffer)
     ;                                                                (message "Evaluated buffer")
     ;                                                                )
     ;   )
     ; (define-key robenkleene/emacs-lisp-eval-leader-map (kbd "r") (lambda (begin end)
     ;                                                                (interactive "r")
     ;                                                                (eval-region begin end)
     ;                                                                (message "Evaluated region")
     ;                                                                (deactivate-mark)
     ;                                                                )
     ;   )
     ; (define-key robenkleene/emacs-lisp-eval-leader-map (kbd "s") 'eval-last-sexp)

     )
  )

(provide 'robenkleene-emacs-lisp)
;;; robenkleene-emacs-lisp.el ends here
