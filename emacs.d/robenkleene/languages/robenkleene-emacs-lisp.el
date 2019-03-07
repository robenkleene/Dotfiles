;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(with-eval-after-load "lisp-mode"

  (define-key robenkleene/leader-map (kbd "e") 'robenkleene/emacs-lisp-eval-buffer-or-region)
  (defun robenkleene/emacs-lisp-eval-buffer-or-region ()
    (interactive)
    (if (use-region-p)
        (call-interactively 'eval-region)
      (call-interactively 'eval-buffer)
      )
    )
  )

(provide 'robenkleene-emacs-lisp)
;;; robenkleene-emacs-lisp.el ends here
