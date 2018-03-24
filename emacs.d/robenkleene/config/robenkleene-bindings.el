;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

(defvar robenkleene-leader)

(define-key global-map (kbd (format "%s o i" robenkleene-leader))
  (lambda()
    (interactive) (find-file "~/.emacs.d/robenkleene/robenkleene.el")))
(define-key global-map (kbd (format "%s t" robenkleene-leader)) 'make-frame-command)

(define-key global-map (kbd "M-n") 'other-frame)
(define-key global-map (kbd "M-p") (lambda () (interactive) (other-frame -1)))


(provide 'robenkleene-bindings)
;;; robenkleene-bindings.el ends here
