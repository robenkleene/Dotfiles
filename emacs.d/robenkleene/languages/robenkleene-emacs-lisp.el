;;; robenkleene-emacs-lisp.el --- robenkleene-emacs-lisp
;;; Commentary:
;;; Code:

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq-local robenkleene/evaluate-buffer-or-region-function
                        'robenkleene/emacs-lisp-eval-buffer-or-region)
            (make-local-variable 'company-backends)
            (add-to-list 'company-backends
                         'company-elisp)
            ))

(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (whitespace-mode 0)
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
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-emacs-lisp.el ends here
