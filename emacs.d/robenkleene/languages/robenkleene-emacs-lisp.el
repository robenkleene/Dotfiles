;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(eval-after-load "lisp-mode"
  '(progn
     ;;; Submaps

     ;; Eval
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

     ;; Linter
     (defvar robenkleene/emacs-lisp-linter-leader-map (make-keymap))
     (define-key robenkleene/emacs-lisp-linter-leader-map (kbd "l") 'flycheck-list-errors)

     ;;; Main Map

     ;; Eval Map
     (defvar robenkleene/emacs-lisp-leader-map (make-keymap))
     (define-key robenkleene/emacs-lisp-leader-map (kbd "e") robenkleene/emacs-lisp-eval-leader-map)
     (define-key robenkleene/emacs-lisp-leader-map (kbd "s") 'helm-semantic-or-imenu)
     (define-key robenkleene/emacs-lisp-leader-map (kbd "l") robenkleene/emacs-lisp-linter-leader-map)
     (define-key robenkleene/emacs-lisp-leader-map (kbd "p") 'robenkleene/print-variable)

     ;; Add map to mode
     (declare-function evil-declare-key "evil")
     (evil-declare-key 'motion emacs-lisp-mode-map (kbd ",") robenkleene/emacs-lisp-leader-map)
     (evil-declare-key 'motion lisp-interaction-mode-map (kbd ",") robenkleene/emacs-lisp-leader-map)
     )
  )

(provide 'robenkleene-emacs-lisp)
;;; robenkleene-emacs-lisp.el ends here
