;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(eval-after-load "lisp-mode"
  '(progn
     (defvar robenkleene/emacs-lisp-eval-leader-map (make-keymap))
     (define-key robenkleene/emacs-lisp-eval-leader-map (kbd "b") (lambda ()
                                                                    (interactive)
                                                                    (eval-buffer)
                                                                    (message "Evaluated buffer")
                                                                    )
       )
     (define-key robenkleene/emacs-lisp-eval-leader-map (kbd "r") (lambda (begin end)
                                                                    (interactive "r")
                                                                    (eval-region begin end)
                                                                    (message "Evaluated region")
                                                                    (deactivate-mark)
                                                                    )
       )
     (define-key robenkleene/emacs-lisp-eval-leader-map (kbd "s") 'eval-last-sexp)

     (defvar robenkleene/emacs-lisp-leader-map (make-keymap))
     (define-key robenkleene/emacs-lisp-leader-map (kbd "e") robenkleene/emacs-lisp-eval-leader-map)

     (declare-function evil-declare-key "evil")
     (evil-declare-key 'motion emacs-lisp-mode-map (kbd ",") robenkleene/emacs-lisp-leader-map)
     (evil-declare-key 'motion lisp-interaction-mode-map (kbd ",") robenkleene/emacs-lisp-leader-map)
     )
  )

(provide 'robenkleene-emacs-lisp)
;;; robenkleene-emacs-lisp.el ends here
