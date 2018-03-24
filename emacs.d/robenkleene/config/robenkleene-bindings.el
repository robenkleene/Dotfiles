;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

(define-key global-map (kbd "C-c t") 'make-frame-command)
(define-key global-map (kbd "C-c n") 'other-frame)
(define-key global-map (kbd "C-c p") (lambda () (interactive) (other-frame -1)))
(define-key global-map (kbd "C-c o i")
  (lambda()
    (interactive) (find-file "~/.emacs.d/robenkleene/robenkleene.el")))

(provide 'robenkleene-bindings)
;;; robenkleene-bindings.el ends here
