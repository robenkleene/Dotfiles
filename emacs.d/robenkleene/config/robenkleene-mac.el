;;; robenkleene-mac.el --- robenkleene-mac
;;; Commentary:
;;; Code:

;; This is the default in `railwaycat/homebrew-emacsmacport'
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

(defvar robenkleene/mac-bindings-minor-mode-map (make-keymap))

(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-`") 'other-frame)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-v") 'yank)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-a") 'mark-whole-buffer)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-x") 'kill-region)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-w") 'delete-frame)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-n") 'make-frame)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-z") 'undo-tree-undo)
(global-set-key (kbd "s-Z") 'undo-tree-redo)

(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-q") 'save-buffers-kill-terminal)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-c") 'kill-ring-save)

;; Mode
(define-minor-mode robenkleene/mac-bindings-minor-mode
  "Mac bindings."
  t
  nil
  'robenkleene/mac-bindings-minor-mode-map)
(robenkleene/mac-bindings-minor-mode 1)

(provide 'robenkleene-mac)
;;; robenkleene-mac.el ends here
