;;; robenkleene-common-lisp.el --- robenkleene-common-lisp
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package slime
  :mode "\\.cl\\'"
  :config
  (setq inferior-lisp-program "~/.brew/bin/sbcl")
  ;; (define-key rk/lisp-eval-leader-map (kbd "b") (lambda ()
  ;;                                                          (interactive)
  ;;                                                          (slime-load-file (buffer-file-name))
  ;;                                                          ;; (slime-compile-and-load-file)
  ;;                                                          (message "Compiled & loaded buffer")
  ;;                                                          )
  ;;   )
  ;; (define-key rk/lisp-eval-leader-map (kbd "r") (lambda (begin end)
  ;;                                                          (interactive "r")
  ;;                                                          (slime-eval-region begin end)
  ;;                                                          (message "Evaluated region")
  ;;                                                          (deactivate-mark)
  ;;                                                          )
  ;;   )
  )

(provide 'robenkleene-common-lisp)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-common-lisp.el ends here
