;;; robenkleene-mac.el --- robenkleene-mac
;;; Commentary:
;;; Code:

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;; Considering options for automatically hiding Emacs when it loses focus, to
;; work better with Mission Control
;; (add-function :after after-focus-change-function
;;               (lambda ()
;;                 (unless (frame-focus-state)
;;                   (call-interactively 'ns-do-hide-emacs))
;;                 ))

(defvar robenkleene/mac-bindings-minor-mode-map (make-keymap))

;; Ergonomic Emacs
;; Basic
;; (define-key key-translation-map (kbd "s-c") (kbd "C-c"))
;; (define-key key-translation-map (kbd "s-s") (kbd "C-s"))
;; (define-key key-translation-map (kbd "s-x") (kbd "C-x"))
;; (define-key key-translation-map (kbd "s-e") (kbd "C-e"))
;; (define-key key-translation-map (kbd "s-f") (kbd "C-f"))
;; (define-key key-translation-map (kbd "s-r") (kbd "C-r"))
;; (define-key key-translation-map (kbd "s-j") (kbd "C-j"))
;; (define-key key-translation-map (kbd "s-b") (kbd "C-b"))
;; (define-key key-translation-map (kbd "s-g") (kbd "C-g"))
;; (define-key key-translation-map (kbd "s-y") (kbd "C-y"))

;; Mac
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-`") 'other-frame)

;; Comment
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-/") 'comment-dwim)

;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-v") 'yank)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-a")
  'mark-whole-buffer)
;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-x") 'kill-region)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-w") 'delete-frame)
;; (define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-n") 'make-frame)

(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-n")
  'robenkleene/make-frame-with-current-frame)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "M-s-n")
  'robenkleene/empty-frame)

(define-key robenkleene/mac-bindings-minor-mode-map (kbd "<s-escape>")
  'robenkleene/other-window-eshell)

;; Mac Style new window
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "s-n")
;;   'robenkleene/empty-frame)
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "M-s-n")
;;   'robenkleene/make-frame-with-current-frame)

(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-O")
  'robenkleene/ido-quick-open-file)

(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-z")
  'undo-tree-undo)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-Z")
  'undo-tree-redo)

;; Disable quit
(global-unset-key (kbd "s-q"))
;; (define-key robenkleene/mac-bindings-minor-mode-map
;;   (kbd "s-q")
;;   'save-buffers-kill-terminal)

(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-c")
  'kill-ring-save)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "C-s-f")
  'toggle-frame-fullscreen)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "<C-s-268632070>")
  'toggle-frame-fullscreen)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-i")
  'robenkleene/save-in-inbox)

;; Search
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-f")
  'isearch-forward-regexp)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-g")
  'isearch-repeat-forward)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-G")
  'isearch-repeat-backward)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "s-F")
  'robenkleene/rg)

;; VS Code Style
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-}") 'other-window)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-{")
  (lambda () (interactive) (other-window -1)))

;; Window Types
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-l")
  'robenkleene/open-emacs-scratch)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-u")
  'robenkleene/new-empty)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "s-y")
  'robenkleene/new-clipboard)

;; Misc
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-v")
  (lambda () (interactive)
    (split-window-horizontally) (other-window 1)))
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-s")
  (lambda () (interactive)
    (split-window-vertically) (other-window 1)))
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-c")
  'delete-window)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-o")
  'delete-other-windows)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-<down>")
  'windmove-down)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-<up>")
  'windmove-up)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-<left>")
  'windmove-left)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "M-s-<right>")
  'windmove-right)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "C-s-e")
  'forward-sentence)
(define-key robenkleene/mac-bindings-minor-mode-map (kbd "C-s-a")
  'backward-sentence)

(define-key key-translation-map (kbd "<s-up>") (kbd "<C-up>"))
(define-key key-translation-map (kbd "<s-down>") (kbd "<C-down>"))
;; (define-key key-translation-map (kbd "<s-left>") (kbd "<C-left>"))
;; (define-key key-translation-map (kbd "<s-right>") (kbd "<C-right>"))
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "<s-left>") 'beginning-of-visual-line)
(define-key robenkleene/mac-bindings-minor-mode-map
  (kbd "<s-right>") 'end-of-visual-line)

;; Quit Emacs if we delete the last frame, which is already what happens if we
;; click the red X to close the window
;; (defun robenkleene/delete-frame-or-kill-emacs ()
;;   "Delete the selected frame.  If the last one, kill Emacs."
;;   (interactive)
;;   (condition-case nil (delete-frame) (error (kill-emacs))))
;; (global-set-key [remap delete-frame] 'robenkleene/delete-frame-or-kill-emacs)
;; Modification of the above that just hides Emacs if there's only one frame
(defun robenkleene/delete-frame-or-hide-emacs ()
  "Delete the selected frame.  If the last one, kill Emacs."
  (interactive)
  (condition-case nil (delete-frame) (error (ns-hide-emacs 1))))
(global-set-key [remap delete-frame] 'robenkleene/delete-frame-or-hide-emacs)


;; Mode
(define-minor-mode robenkleene/mac-bindings-minor-mode
  "Mac bindings."
  t
  nil
  'robenkleene/mac-bindings-minor-mode-map)
(robenkleene/mac-bindings-minor-mode 1)

(defun robenkleene/search-selection (beg end)
  "Search for BEG END text."
  (interactive "r")
  (let (
        (selection (buffer-substring-no-properties beg end))
        )
    (deactivate-mark)
    (isearch-mode t nil nil nil)
    (isearch-yank-string selection)
    )
  )
(define-key global-map (kbd "s-e") 'robenkleene/search-selection)

(provide 'robenkleene-mac)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-mac.el ends here
