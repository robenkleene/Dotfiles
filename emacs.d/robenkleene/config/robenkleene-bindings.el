;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; These use `global-set-key' so more specific minor modes can override them,
;; e.g., the minibuffer
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;; Maps
(defvar robenkleene/bindings-minor-mode-map (make-keymap))
(defvar robenkleene/leader-map (make-keymap))

;; Automatically switch focus to new splits
(define-key robenkleene/bindings-minor-mode-map "\C-x2" (lambda ()
                          (interactive)
                          (split-window-vertically)
                          (other-window 1)))
(define-key robenkleene/bindings-minor-mode-map "\C-x3"
  (lambda ()
    (interactive)
    (split-window-horizontally)
    (other-window 1)))
;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-`") 'other-window)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-`")
  'robenkleene/other-window-shell)

(define-key robenkleene/bindings-minor-mode-map (kbd "C-~")
  (lambda () (interactive) (other-window -1)))

;; Set these in such a way that other modes override, e.g., to make the bindings
;; access history in shell modes
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'next-error)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-p") 'previous-error)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'robenkleene/next)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-p")
  'robenkleene/previous)



;; (define-key robenkleene/bindings-minor-mode-map
;;   (kbd "M-C-d") 'robenkleene/archive-and-delete)

;; History keys in isearch
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)

;; Add a second leader key
;; (define-key key-translation-map (kbd "M-o") (kbd "C-c"))
;; These should be added only for terminal modes
;; (define-key key-translation-map (kbd "<M-up>") (kbd "M-p"))
;; (define-key key-translation-map (kbd "<M-down>") (kbd "M-n"))

(define-key robenkleene/bindings-minor-mode-map (kbd "C-M-s") 'isearch-forward)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-M-r") 'isearch-backward)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-%")
  'query-replace-regexp)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-M-%") 'query-replace)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-w")
  'robenkleene/kill-region-or-backward-word)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-x c")
  'save-buffers-kill-terminal)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-h C-f") 'find-function)

;; These commands are part of a general strategy of mapping the command key to
;; the control key in Emacs
(define-key robenkleene/bindings-minor-mode-map (kbd "<C-up>")
  'beginning-of-buffer)
(define-key robenkleene/bindings-minor-mode-map (kbd "<C-down>") 'end-of-buffer)
(define-key robenkleene/bindings-minor-mode-map (kbd "<C-left>")
  'move-beginning-of-line)
(define-key robenkleene/bindings-minor-mode-map (kbd "<C-right>")
  'move-end-of-line)

(define-key robenkleene/bindings-minor-mode-map
  (kbd "<M-S-down>") 'robenkleene/duplicate-line-below)
(define-key robenkleene/bindings-minor-mode-map
  (kbd "<M-S-up>") 'robenkleene/duplicate-line-above)
(define-key robenkleene/bindings-minor-mode-map
  (kbd "<C-s-left>") 'winner-undo)
(define-key robenkleene/bindings-minor-mode-map
  (kbd "<C-s-right>") 'winner-redo)

;; General
(define-key robenkleene/bindings-minor-mode-map (kbd "C-x C-o") 'other-window)

(define-key robenkleene/bindings-minor-mode-map (kbd "M-;")
  'robenkleene/comment)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-r")
  'robenkleene/reveal-in-finder)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-t")
  'robenkleene/open-terminal-window)

;; ido
(define-key robenkleene/bindings-minor-mode-map (kbd "M-g")
  'robenkleene/ido-quick-developer)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-z")
;;   'robenkleene/ido-z)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-\\")
  'robenkleene/ido-clipboard-history-copy)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-x C-b")
  'ibuffer)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-x C-r")
  'robenkleene/ido-recent-find-file)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-o")
;;   'robenkleene/ido-recursive-find-file)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-e")
;;   'robenkleene/ido-recursive-find-file)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-c")
;;   'robenkleene/ido-recursive-find-dir)


;; Leader Map
;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-c")
;;   robenkleene/leader-map)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-a")
  robenkleene/leader-map)
;; The problem with `M-o' is that `o' is the binding for closing other panes
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-o")
;;   robenkleene/leader-map)
;; Mac-like save in terminal and GUI
;; (define-key robenkleene/bindings-minor-mode-map (kbd "s-s") 'save-buffer)
(define-key robenkleene/bindings-minor-mode-map
  (kbd "C-x s-s") 'save-buffer)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-l")
;;   'robenkleene/urls-open)
(if window-system
    (progn
      ;; This results in a quick search being automatically triggered on startup
      ;; in terminal Emacs.
      ;; These result in inserting characters into the scratch buffer on Emacs
      ;; startup in terminal Emacs.
      (define-key robenkleene/bindings-minor-mode-map (kbd "M-]")
        'robenkleene/forward-block)
      (define-key robenkleene/bindings-minor-mode-map (kbd "M-}")
        'robenkleene/forward-block-select)
      (define-key robenkleene/bindings-minor-mode-map (kbd "M-[")
        'robenkleene/backward-block)
      (define-key robenkleene/bindings-minor-mode-map (kbd "M-{")
        'robenkleene/backward-block-select)
      ))

;; Leader map
;; (define-key robenkleene/leader-map (kbd "w") 'visual-line-mode)
(define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
;; (define-key robenkleene/leader-map (kbd "t") 'robenkleene/other-window-shell)
(define-key robenkleene/leader-map (kbd "`") 'robenkleene/other-window-eshell)
;; (define-key robenkleene/leader-map (kbd "a") 'robenkleene/archive)
(define-key robenkleene/leader-map (kbd "d") 'robenkleene/archive-and-delete)
;; (define-key robenkleene/leader-map (kbd "q") 'save-buffers-kill-terminal)
;; (define-key robenkleene/leader-map (kbd "s") 'save-buffer)
;; (define-key robenkleene/leader-map (kbd "r") 'robenkleene/reveal-in-finder)
(define-key robenkleene/leader-map (kbd "C-f") 'robenkleene/format)
(define-key robenkleene/leader-map (kbd "C-r") 'robenkleene/run)
(define-key robenkleene/leader-map (kbd "C-e")
  'robenkleene/evaluate-buffer-or-region)
(define-key robenkleene/leader-map (kbd "k")
  'robenkleene/wiki-link) ;; This is only for Markdown
(define-key robenkleene/leader-map (kbd "C-k")
  'robenkleene/wiki-link) ;; This is only for Markdown
;; (define-key robenkleene/leader-map (kbd "s")
;;   'robenkleene/web-search)
;; (define-key robenkleene/leader-map (kbd "C")
;;   'robenkleene/title-case)
(define-key robenkleene/leader-map (kbd "r")
  'robenkleene/reveal-in-finder)
(global-set-key (kbd "C-c c")
                'robenkleene/title-case)
(define-key robenkleene/leader-map (kbd "*")
  'isearch-forward-symbol-at-point)
(define-key robenkleene/leader-map (kbd "u")
  'robenkleene/new-empty)

;; Leader Map ido
(define-key robenkleene/leader-map (kbd "a") 'robenkleene/rg)
;; (define-key robenkleene/leader-map (kbd "M-o")
;;   'robenkleene/ido-recursive-insert-file)
;; (define-key robenkleene/leader-map (kbd "M-c")
;;   'robenkleene/ido-recursive-find-file)
(define-key robenkleene/leader-map (kbd "C")
  'robenkleene/ido-recursive-find-dir)
;; (define-key robenkleene/leader-map (kbd "g M-o")
;;   'robenkleene/ido-source-control-recursive-find-file)
;; (define-key robenkleene/leader-map (kbd "g M-c")
;;   'robenkleene/ido-source-control-recursive-find-dir)
;; (define-key robenkleene/leader-map (kbd "y f")
;;   'robenkleene/yank-filename)
;; (define-key robenkleene/leader-map (kbd "y d")
;;   'robenkleene/yank-directory)
;; (define-key robenkleene/leader-map (kbd "y p")
;;   'robenkleene/yank-filepath)
(define-key robenkleene/leader-map (kbd "z") 'robenkleene/ido-bookmark-jump)
(define-key robenkleene/leader-map (kbd "B")
  'ido-switch-buffer)
;; (define-key robenkleene/leader-map (kbd "\\")
;;   'robenkleene/ido-clipboard-history-copy)
;; Alternatives to helm
(define-key robenkleene/leader-map (kbd "I") 'imenu)
(define-key robenkleene/leader-map (kbd "L") 'occur)

;; Window Management
(define-key robenkleene/leader-map
  (kbd "t")
  (lambda () (interactive) (make-frame) (other-frame 1)))
(define-key robenkleene/leader-map
  (kbd "M-t")
  (lambda () (interactive) (make-frame) (other-frame 1)))
(define-key robenkleene/leader-map (kbd "n") 'other-frame)
(define-key robenkleene/leader-map (kbd "p")
  (lambda () (interactive) (other-frame -1)))
(define-key robenkleene/leader-map (kbd "M-n") 'other-frame)
(define-key robenkleene/leader-map (kbd "M-p")
  (lambda () (interactive) (split-window-horizontally) (other-frame -1)))
(define-key robenkleene/leader-map (kbd "M-a") 'other-window)
;; (define-key robenkleene/leader-map (kbd "M-o") 'other-window)
(define-key robenkleene/leader-map (kbd "q") 'delete-frame)
(define-key robenkleene/leader-map (kbd "v")
  (lambda () (interactive) (split-window-horizontally) (other-window 1)))
(define-key robenkleene/leader-map (kbd "M-v")
  (lambda () (interactive) (split-window-horizontally) (other-window 1)))
(define-key robenkleene/leader-map (kbd "s")
  (lambda () (interactive) (split-window-vertically) (other-window 1)))
(define-key robenkleene/leader-map (kbd "M-s")
  (lambda () (interactive) (split-window-vertically) (other-window 1)))

(define-key robenkleene/leader-map (kbd "c") 'delete-window)
(define-key robenkleene/leader-map (kbd "o") 'delete-other-windows)
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
  :init-value t
  :lighter nil
  :keymap 'robenkleene/bindings-minor-mode-map)
(robenkleene/bindings-minor-mode 1)

(add-hook 'after-load-functions 'robenkleene/ensure-binding-priority)

(defun robenkleene/ensure-binding-priority (_file)
  "Ensure `bindings-minor-mode' always has priority."
  (unless (eq (caar minor-mode-map-alist) 'robenkleene/bindings-minor-mode)
    (let ((new-keys
           (assq 'robenkleene/bindings-minor-mode minor-mode-map-alist)))
      (assq-delete-all 'robenkleene/bindings-minor-mode minor-mode-map-alist)
      (add-to-list 'minor-mode-map-alist new-keys))))

(provide 'robenkleene-bindings)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-bindings.el ends here
