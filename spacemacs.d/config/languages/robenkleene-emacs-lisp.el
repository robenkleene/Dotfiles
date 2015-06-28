;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(defun robenkleene/emacs-lisp ()
  "Setup Emacs Lips."
  (linum-mode t)
  (flycheck-mode)
  )
(add-hook 'emacs-lisp-mode-hook 'robenkleene/emacs-lisp)

(provide 'robenkleene-emacs-lisp)
;;; robenkleene-emacs-lisp.el ends here
