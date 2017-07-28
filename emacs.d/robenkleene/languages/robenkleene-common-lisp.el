;;; robenkleene-common-lisp.el --- robenkleene-common-lisp
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package slime
  :defer t
  :config
  (setq inferior-lisp-program "/usr/local/bin/sbcl")
  ;; (define-key robenkleene/lisp-eval-leader-map (kbd "b") (lambda ()
  ;;                                                          (interactive)
  ;;                                                          (slime-load-file (buffer-file-name))
  ;;                                                          ;; (slime-compile-and-load-file)
  ;;                                                          (message "Compiled & loaded buffer")
  ;;                                                          )
  ;;   )
  ;; (define-key robenkleene/lisp-eval-leader-map (kbd "r") (lambda (begin end)
  ;;                                                          (interactive "r")
  ;;                                                          (slime-eval-region begin end)
  ;;                                                          (message "Evaluated region")
  ;;                                                          (deactivate-mark)
  ;;                                                          )
  ;;   )
  )

(provide 'robenkleene-common-lisp)
;;; robenkleene-common-lisp.el ends here
