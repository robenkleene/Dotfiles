;;; robenkleene-mac.el --- robenkleene-mac
;;; Commentary:
;;; Code:

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

(defvar robenkleene/mac-bindings-minor-mode-map (make-keymap))

;; Ergonomic Emacs
;; Basic
(define-key key-translation-map (kbd "s-c") (kbd "C-c"))
(define-key key-translation-map (kbd "s-x") (kbd "C-x"))
;; For evaluate
(define-key key-translation-map (kbd "s-e") (kbd "C-e"))
;; For find file and format
(define-key key-translation-map (kbd "s-f") (kbd "C-f"))
;; For run
(define-key key-translation-map (kbd "s-r") (kbd "C-r"))
;; For save
;; (define-key key-translation-map (kbd "s-s") (kbd "C-s"))
;; For dired jump
(define-key key-translation-map (kbd "s-j") (kbd "C-j"))
;; For `ibuffer'
(define-key key-translation-map (kbd "s-b") (kbd "C-b"))
;; For keyboard quit
(define-key key-translation-map (kbd "s-g") (kbd "C-g"))

;; Mac
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-`") 'other-frame)
;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-v") 'yank)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-a")
  'mark-whole-buffer)
;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-x") 'kill-region)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-w") 'delete-frame)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-n") 'make-frame)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "s-n")
;;   'robenkleene/empty-frame)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "s-z")
;;   'undo-tree-undo)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "s-Z")
;;   'undo-tree-redo)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-q")
  'save-buffers-kill-terminal)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "s-c")
;;   'kill-ring-save)

;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "<s-up>")
;;   'beginning-of-buffer)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "<s-down>")
;;   'end-of-buffer)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "<s-left>")
;;   'move-beginning-of-line)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "<s-right>")
;;   'move-end-of-line)

(define-key key-translation-map (kbd "<s-up>") (kbd "<C-up>"))
(define-key key-translation-map (kbd "<s-down>") (kbd "<C-down>"))
(define-key key-translation-map (kbd "<s-left>") (kbd "<C-left>"))
(define-key key-translation-map (kbd "<s-right>") (kbd "<C-right>"))

;; Mode
(define-minor-mode robenkleene/mac-bindings-minor-mode
  "Mac bindings."
  t
  nil
  'robenkleene/mac-bindings-minor-mode-map)
(robenkleene/mac-bindings-minor-mode 1)

(provide 'robenkleene-mac)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-mac.el ends here
