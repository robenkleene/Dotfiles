;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(add-hook 'lisp-mode-hook
          (lambda ()
            (setq robenkleene/evaluate-buffer-or-region-function 'robenkleene/emacs-lisp-eval-buffer-or-region)
            )
          )

(with-eval-after-load "lisp-mode"
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
