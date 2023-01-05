;;; robenkleene-mac.el --- robenkleene-mac
;;; Commentary:
;;; Code:

;; Fix cut & paste
;; Need to store the last paste because the function should only return a value
;; if it's different than the last paste
(setq rk/last-paste nil)
(defun rk/copy-from-osx ()
  (let ((copied-text (shell-command-to-string "pbpaste")))
    (unless (string= copied-text rk/last-paste)
      copied-text)))
(setq interprogram-paste-function 'rk/copy-from-osx)

(defun rk/paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc)))
  (setq rk/last-paste text)
  )
(setq interprogram-cut-function 'rk/paste-to-osx)

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;; Hide the window title completely, which looks cool
;; This works by moving the frame size information to the second line which
;; isn't visible
(setq-default frame-title-format '("\n"))
(setq ns-use-proxy-icon nil)

;; Considering options for automatically hiding Emacs when it loses focus, to
;; work better with Mission Control
;; (add-function :after after-focus-change-function
;;               (lambda ()
;;                 (unless (frame-focus-state)
;;                   (call-interactively 'ns-do-hide-emacs))
;;                 ))

(defvar rk/mac-bindings-minor-mode-map (make-keymap))

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
(define-key rk/mac-bindings-minor-mode-map (kbd "s-`") 'other-frame)

;; Comment
(define-key rk/mac-bindings-minor-mode-map (kbd "s-/") 'comment-dwim)

;; (define-key rk/mac-bindings-minor-mode-map (kbd "s-v") 'yank)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-a")
  'mark-whole-buffer)
;; (define-key rk/mac-bindings-minor-mode-map (kbd "s-x") 'kill-region)
(define-key rk/mac-bindings-minor-mode-map (kbd "s-w") 'delete-frame)
;; (define-key rk/mac-bindings-minor-mode-map (kbd "s-n") 'make-frame)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-q")
  'save-buffers-kill-terminal)

(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-n")
  'rk/make-frame-with-current-frame)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "M-s-n")
  'rk/empty-frame)

(define-key rk/mac-bindings-minor-mode-map (kbd "<s-escape>")
  'rk/other-window-eshell)

;; Mac Style new window
;; (define-key rk/mac-bindings-minor-mode-map
;;   (kbd "s-n")
;;   'rk/empty-frame)
;; (define-key rk/mac-bindings-minor-mode-map
;;   (kbd "M-s-n")
;;   'rk/make-frame-with-current-frame)

(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-z")
  'undo-only)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-Z")
  'undo-redo)

;; Disable quit
(global-unset-key (kbd "s-q"))
;; (define-key rk/mac-bindings-minor-mode-map
;;   (kbd "s-q")
;;   'save-buffers-kill-terminal)

(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-c")
  'kill-ring-save)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "C-s-f")
  'toggle-frame-fullscreen)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "<C-s-268632070>")
  'toggle-frame-fullscreen)

;; Search
(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-f")
  'isearch-forward-regexp)
;; (define-key rk/mac-bindings-minor-mode-map
;;   (kbd "s-g")
;;   'isearch-forward-repeat)
(define-key key-translation-map (kbd "s-g") (kbd "C-s"))
;; (define-key rk/mac-bindings-minor-mode-map
;;   (kbd "s-G")
;;   'isearch-repeat-backward)
(define-key key-translation-map (kbd "s-G") (kbd "C-r"))
(define-key rk/mac-bindings-minor-mode-map
  (kbd "s-F")
  'rk/rg)

;; VS Code Style
(define-key rk/mac-bindings-minor-mode-map (kbd "s-}") 'other-window)
(define-key rk/mac-bindings-minor-mode-map (kbd "s-{")
  (lambda () (interactive) (other-window -1)))

;; Misc
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-v")
  (lambda () (interactive)
    (split-window-horizontally) (other-window 1)))
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-s")
  (lambda () (interactive)
    (split-window-vertically) (other-window 1)))
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-c")
  'delete-window)
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-o")
  'delete-other-windows)
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-w")
  'delete-other-frames)
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-<down>")
  'windmove-down)
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-<up>")
  'windmove-up)
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-<left>")
  'windmove-left)
(define-key rk/mac-bindings-minor-mode-map (kbd "M-s-<right>")
  'windmove-right)
(define-key rk/mac-bindings-minor-mode-map (kbd "C-s-e")
  'forward-sentence)
(define-key rk/mac-bindings-minor-mode-map (kbd "C-s-a")
  'backward-sentence)

(define-key key-translation-map (kbd "<s-up>") (kbd "<C-up>"))
(define-key key-translation-map (kbd "<s-down>") (kbd "<C-down>"))
;; (define-key key-translation-map (kbd "<s-left>") (kbd "<C-left>"))
;; (define-key key-translation-map (kbd "<s-right>") (kbd "<C-right>"))
(define-key rk/mac-bindings-minor-mode-map
  (kbd "<s-left>") 'beginning-of-visual-line)
(define-key rk/mac-bindings-minor-mode-map
  (kbd "<s-right>") 'end-of-visual-line)

;; Quit Emacs if we delete the last frame, which is already what happens if we
;; click the red X to close the window
;; (defun rk/delete-frame-or-kill-emacs ()
;;   "Delete the selected frame.  If the last one, kill Emacs."
;;   (interactive)
;;   (condition-case nil (delete-frame) (error (kill-emacs))))
;; (global-set-key [remap delete-frame] 'rk/delete-frame-or-kill-emacs)
;; Modification of the above that just hides Emacs if there's only one frame
(defun rk/delete-frame-or-hide-emacs ()
  "Delete the selected frame.  If the last one, kill Emacs."
  (interactive)
  (condition-case nil (delete-frame) (error (ns-hide-emacs 1))))
(global-set-key [remap delete-frame] 'rk/delete-frame-or-hide-emacs)


;; Mode
(define-minor-mode rk/mac-bindings-minor-mode
  "Mac bindings."
  :init-value t
  :lighter nil
  :keymap 'rk/mac-bindings-minor-mode-map)
(rk/mac-bindings-minor-mode 1)

(defun rk/search-selection (beg end)
  "Search for BEG END text."
  (interactive "r")
  (let (
        (selection (buffer-substring-no-properties beg end))
        )
    (deactivate-mark)
    (isearch-forward nil 1)
    ;; (isearch-mode t nil nil nil)
    (isearch-yank-string selection)
    )
  )
(define-key global-map (kbd "s-e") 'rk/search-selection)

(provide 'robenkleene-mac)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-mac.el ends here
