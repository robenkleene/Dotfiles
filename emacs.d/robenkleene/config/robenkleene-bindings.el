;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; Global
(define-key global-map (kbd "M-n") 'other-frame)
(define-key global-map (kbd "M-p") (lambda () (interactive) (other-frame -1)))

;; Leader map
(defvar robenkleene/leader-map (make-keymap))
(define-key global-map (kbd "M-o") robenkleene/leader-map)
(define-key robenkleene/leader-map (kbd "o i")
  (lambda()
    (interactive) (find-file "~/.emacs.d/robenkleene/robenkleene.el")))
(define-key robenkleene/leader-map (kbd "t") 'make-frame-command)

(provide 'robenkleene-bindings)
;;; robenkleene-bindings.el ends here
