;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; Maps
(defvar robenkleene/bindings-minor-mode-map (make-keymap))
(defvar robenkleene/leader-map (make-keymap))

;; Leader Map
(global-unset-key (kbd "M-o"))
(define-key robenkleene/bindings-minor-mode-map (kbd "M-o") robenkleene/leader-map)

;; Global
(define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'other-frame)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-p") (lambda () (interactive) (other-frame -1)))
(define-key robenkleene/bindings-minor-mode-map (kbd "M-t") 'make-frame-command)

;; Leader map
(define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
(define-key robenkleene/leader-map (kbd "o i") 'robenkleene/edit-init)
(define-key robenkleene/leader-map (kbd "R") 'robenkleene/reveal-in-finder)

;; Mode
(define-minor-mode robenkleene/bindings-minor-mode
  "My bindings."
  t
  nil
  'robenkleene/bindings-minor-mode-map)
(robenkleene/bindings-minor-mode 1)

(provide 'robenkleene-bindings)
;;; robenkleene-bindings.el ends here
