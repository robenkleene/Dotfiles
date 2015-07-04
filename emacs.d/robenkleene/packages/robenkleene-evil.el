;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(require 'evil)

;; Disable Evil's integrations
(defun evil-make-overriding-map (keymap &optional state copy)
  "No-op."
  )
(defmacro evil-add-hjkl-bindings (keymap &optional state &rest bindings)
  "No-op."
  )

(evil-mode 1)

(define-key evil-normal-state-map "-" 'dired-jump)
(define-key evil-motion-state-map "-" 'dired-jump)

;; Let default bindings for mode poke through
(define-key evil-normal-state-map (kbd "RET") nil)
(define-key evil-motion-state-map (kbd "RET") nil)

;;; Leader

;; Leader Map
(defvar robenkleene/leader-map (make-keymap))
(define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
(define-key robenkleene/leader-map (kbd "t") 'robenkleene/open-terminal-window)
(define-key robenkleene/leader-map (kbd "f") 'robenkleene/open-finder-window)
(define-key robenkleene/leader-map (kbd "a") 'helm-do-ag)

;; Leader Key
(define-key evil-normal-state-map (kbd "\\") robenkleene/leader-map)
(define-key evil-motion-state-map (kbd "\\") robenkleene/leader-map)

;;; Unimpaired

;; Unimpaired Map
(defvar robenkleene/unimpaired-next-map (make-keymap))
(defvar robenkleene/unimpaired-previous-map (make-keymap))
(define-key robenkleene/unimpaired-next-map (kbd "q") 'next-error)
(define-key robenkleene/unimpaired-previous-map (kbd "q") 'previous-error)
(define-key robenkleene/unimpaired-next-map (kbd "b") 'next-buffer)
(define-key robenkleene/unimpaired-previous-map (kbd "b") 'previous-buffer)

;; Unimpaired Key
(define-key evil-normal-state-map (kbd "[") robenkleene/unimpaired-previous-map)
(define-key evil-normal-state-map (kbd "]") robenkleene/unimpaired-next-map)
(define-key evil-motion-state-map (kbd "[") robenkleene/unimpaired-previous-map)
(define-key evil-motion-state-map (kbd "]") robenkleene/unimpaired-next-map)


(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here
