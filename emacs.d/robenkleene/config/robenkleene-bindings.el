;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; Automatically switch focus to new splits
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;; Note this doesn't work in Terminal Emacs
(global-set-key [escape] 'keyboard-escape-quit)

;; Maps
(defvar robenkleene/bindings-minor-mode-map (make-keymap))
(defvar robenkleene/leader-map (make-keymap))

;; General
(define-key robenkleene/bindings-minor-mode-map (kbd "M-e") 'robenkleene/ido-recursive-find-file)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-x C-o") 'other-window)

;; Leader Map
(define-key robenkleene/bindings-minor-mode-map (kbd "C-c") robenkleene/leader-map)

;; Global
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'other-frame)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-p") (lambda () (interactive) (other-frame -1)))
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-t") (lambda ()
;;                                                               (interactive)
;;                                                               (make-frame-command)
;;                                                               ))
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-t") (lambda ()
;;                                                               (interactive)
;;                                                               (make-frame-command)
;;                                                               (switch-to-buffer "*scratch*")
;;                                                               ))
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-s") 'save-buffer)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-S") 'save-buffers-kill-terminal)

;; Leader map
(define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
(define-key robenkleene/leader-map (kbd "s") 'robenkleene/other-window-shell)
(define-key robenkleene/leader-map (kbd "o i") 'robenkleene/edit-init)

;; (define-key robenkleene/leader-map (kbd "q") 'save-buffers-kill-terminal)
;; (define-key robenkleene/leader-map (kbd "s") 'save-buffer)
(define-key robenkleene/leader-map (kbd "R") 'robenkleene/reveal-in-finder)
;; Window Management
;; (define-key robenkleene/leader-map (kbd "M-o") 'other-window)
;; (define-key robenkleene/leader-map (kbd "o") 'other-window)
;; (define-key robenkleene/leader-map (kbd "1") 'delete-other-windows)
;; (define-key robenkleene/leader-map (kbd "2") 'split-window-below)
;; (define-key robenkleene/leader-map (kbd "3") 'split-window-right)
;; (define-key robenkleene/leader-map (kbd "0") 'delete-window)
;; (define-key robenkleene/leader-map (kbd "<left>") 'previous-buffer)
;; (define-key robenkleene/leader-map (kbd "<right>") 'next-buffer)

;; Mode
(define-minor-mode robenkleene/bindings-minor-mode
  "My bindings."
  t
  nil
  'robenkleene/bindings-minor-mode-map)
(robenkleene/bindings-minor-mode 1)

(provide 'robenkleene-bindings)
;;; robenkleene-bindings.el ends here
