;;; robenkleene-mac.el --- robenkleene-mac
;;; Commentary:
;;; Code:

;; This is the default in `railwaycat/homebrew-emacsmacport'
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;; This fixes issues with `railwaycat' Emacs and spaces
;; Emacs frames now stay in their space and lose focus less often
;; (But they still lose focus sometimes)
(menu-bar-mode 1)

(defvar robenkleene/mac-bindings-minor-mode-map (make-keymap))

;; More Ergonomic Emacs
(define-key key-translation-map (kbd "s-h") (kbd "C-h"))
(define-key key-translation-map (kbd "s-c") (kbd "C-c"))
(define-key key-translation-map (kbd "s-x") (kbd "C-x"))
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "C-x s-o") 'other-window)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "C-x s-j") 'dired-jump)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "C-x s-f") 'find-file-at-point)


;; Mac
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-`") 'other-frame)
;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-v") 'yank)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-a") 'mark-whole-buffer)
;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-x") 'kill-region)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-w") 'delete-frame)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-n") 'make-frame)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-z") 'undo-tree-undo)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-Z") 'undo-tree-redo)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-s") 'save-buffer)

(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-q") 'save-buffers-kill-terminal)
;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-c") 'kill-ring-save)

(define-key robenkleene/mac-bindings-minor-mode-map (kbd "<s-up>") 'beginning-of-buffer)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "<s-down>") 'end-of-buffer)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "<s-left>") 'move-beginning-of-line)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "<s-right>") 'move-end-of-line)

;; Mode
(define-minor-mode robenkleene/mac-bindings-minor-mode
  "Mac bindings."
  t
  nil
  'robenkleene/mac-bindings-minor-mode-map)
(robenkleene/mac-bindings-minor-mode 1)

(provide 'robenkleene-mac)
;;; robenkleene-mac.el ends here
