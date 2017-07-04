;;; robenkleene-evil-unimpaired-map.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; Unimpaired Map
(defvar robenkleene/unimpaired-next-map (make-keymap))
(defvar robenkleene/unimpaired-previous-map (make-keymap))
(define-key robenkleene/unimpaired-next-map (kbd "q") 'next-error)
(define-key robenkleene/unimpaired-previous-map (kbd "q") 'previous-error)
(define-key robenkleene/unimpaired-next-map (kbd "b") 'next-buffer)
(define-key robenkleene/unimpaired-previous-map (kbd "b") 'previous-buffer)
(define-key robenkleene/unimpaired-next-map (kbd "c") 'git-gutter:next-hunk)
(define-key robenkleene/unimpaired-previous-map (kbd "c") 'git-gutter:previous-hunk)

;; Unimpaired Key
(define-key evil-motion-state-map (kbd "[") robenkleene/unimpaired-previous-map)
(define-key evil-motion-state-map (kbd "]") robenkleene/unimpaired-next-map)

(provide 'robenkleene-evil-unimpaired-map)

;;; robenkleene-evil-unimpaired-map.el ends here
