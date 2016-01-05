;;; robenkleene-common-lisp.el --- robenkleene-common-lisp
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package slime
  :ensure t
  :defer t
  :config
  (progn
    (setq inferior-lisp-program "/usr/local/bin/sbcl")
    
    (defvar robenkleene/lisp-eval-leader-map (make-keymap))
    (define-key robenkleene/lisp-eval-leader-map (kbd "b") (lambda ()
                                                             (interactive)
                                                             (slime-load-file (buffer-file-name))
                                                             ;; (slime-compile-and-load-file)
                                                             (message "Compiled & loaded buffer")
                                                             )
      )
    (define-key robenkleene/lisp-eval-leader-map (kbd "r") (lambda (begin end)
                                                             (interactive "r")
                                                             (slime-eval-region begin end)
                                                             (message "Evaluated region")
                                                             (deactivate-mark)
                                                             )
      )

    ;; Maps
    (defvar robenkleene/emacs-lisp-leader-map (make-keymap))
    (define-key robenkleene/emacs-lisp-leader-map (kbd "e") robenkleene/lisp-eval-leader-map)

    ;; Add maps to mode
    (declare-function evil-declare-key "evil")
    (evil-declare-key 'motion lisp-mode-map (kbd "\\") robenkleene/emacs-lisp-leader-map)
    )
  )

(provide 'robenkleene-common-lisp)
;;; robenkleene-common-lisp.el ends here
