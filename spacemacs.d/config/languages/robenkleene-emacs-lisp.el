;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(declare-function flycheck-mode "flycheck" (&optional ARG))
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  ;; linum-mode is not compatible with git-gutter
                                  ;; (linum-mode t)
                                  (flycheck-mode)
                                  ))

(provide 'robenkleene-emacs-lisp)
;;; robenkleene-emacs-lisp.el ends here
