;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; New Maps
(defvar robenkleene/bindings-minor-mode-map (make-keymap))
(defvar robenkleene/leader-map (make-keymap))
(defvar robenkleene/window-map (make-keymap))

;; Search & Replace

;; These use `global-set-key' so more specific minor modes can override them,
;; e.g., the minibuffer
;; (global-set-key (kbd "C-s") 'isearch-forward-regexp)
;; (global-set-key (kbd "C-r") 'isearch-backward-regexp)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-M-s") 'isearch-forward)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-M-r") 'isearch-backward)
;; Swap query replace
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-%")
;;   'query-replace-regexp)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-M-%") 'query-replace)

;; History keys in isearch
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)

;; Window Management

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

;; Others

;; Tweak comment behavior
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-;")
;;   'robenkleene/comment)

;; Improve completion
(global-set-key (kbd "M-/") 'hippie-expand)

;; New Keys

;; Set these in such a way that other modes override, e.g., to make the bindings
;; access history in shell modes
(define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'robenkleene/next)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-p")
  'robenkleene/previous)

(define-key robenkleene/bindings-minor-mode-map (kbd "C-w")
  'robenkleene/kill-region-or-backward-word)

;; (define-key robenkleene/bindings-minor-mode-map
;;   (kbd "<M-S-down>") 'robenkleene/duplicate-line-below)
;; (define-key robenkleene/bindings-minor-mode-map
;;   (kbd "<M-S-up>") 'robenkleene/duplicate-line-above)

;; General

(define-key robenkleene/bindings-minor-mode-map (kbd "M-r")
  'robenkleene/reveal-in-finder)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-t")
  'robenkleene/open-terminal-window)

;; ido
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-z")
;;   'robenkleene/ido-z)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-\\")
  'robenkleene/ido-clipboard-history-copy)

;; Leader Key
;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-c")
;;   robenkleene/leader-map)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-a")
;;   robenkleene/leader-map)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-W")
  robenkleene/window-map)
;; The problem with `M-o' is that `o' is the binding for closing other panes
(define-key robenkleene/bindings-minor-mode-map (kbd "M-o")
  robenkleene/leader-map)

;; Core Fuzzy Keys

;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-o")
;;   'robenkleene/ido-recursive-find-file)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-e")
;;   'robenkleene/ido-recursive-find-file)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-c")
;;   'robenkleene/ido-recursive-find-dir)

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

;; Other

;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-l")
;;   'robenkleene/urls-open)

;; (if window-system
;;     (progn
;;       ;; This results in a quick search being automatically triggered on startup
;;       ;; in terminal Emacs.
;;       ;; These result in inserting characters into the scratch buffer on Emacs
;;       ;; startup in terminal Emacs.
;;       (define-key robenkleene/bindings-minor-mode-map (kbd "M-]")
;;         'robenkleene/forward-block)
;;       (define-key robenkleene/bindings-minor-mode-map (kbd "M-}")
;;         'robenkleene/forward-block-select)
;;       (define-key robenkleene/bindings-minor-mode-map (kbd "M-[")
;;         'robenkleene/backward-block)
;;       (define-key robenkleene/bindings-minor-mode-map (kbd "M-{")
;;         'robenkleene/backward-block-select)
;;       ))

;; Leader map
(define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
(define-key robenkleene/leader-map (kbd "`") 'robenkleene/other-window-eshell)
(define-key robenkleene/leader-map (kbd "d") 'robenkleene/archive-and-delete)

;; (define-key robenkleene/leader-map (kbd "C-e")
;;   'robenkleene/evaluate-buffer-or-region)

;; Core Window Management

;; Leader-Key Based
;; (define-key robenkleene/leader-map
;;   (kbd "t")
;;   (lambda () (interactive) (make-frame) (other-frame 1)))
;; (define-key robenkleene/leader-map
;;   (kbd "M-t")
;;   (lambda () (interactive) (make-frame) (other-frame 1)))
;; (define-key robenkleene/leader-map (kbd "n") 'other-frame)
;; (define-key robenkleene/leader-map (kbd "p")
;;   (lambda () (interactive) (other-frame -1)))
;; (define-key robenkleene/leader-map (kbd "M-n") 'other-frame)
;; (define-key robenkleene/leader-map (kbd "M-p")
;;   (lambda () (interactive) (split-window-horizontally) (other-frame -1)))
;; (define-key robenkleene/leader-map (kbd "M-a") 'other-window)
;; (define-key robenkleene/leader-map (kbd "M-W") 'other-window)
;; ;; (define-key robenkleene/leader-map (kbd "M-o") 'other-window)
;; (define-key robenkleene/leader-map (kbd "q") 'delete-frame)
;; (define-key robenkleene/leader-map (kbd "v")
;;   (lambda () (interactive) (split-window-horizontally) (other-window 1)))
;; (define-key robenkleene/leader-map (kbd "M-v")
;;   (lambda () (interactive) (split-window-horizontally) (other-window 1)))
;; (define-key robenkleene/leader-map (kbd "s")
;;   (lambda () (interactive) (split-window-vertically) (other-window 1)))
;; (define-key robenkleene/leader-map (kbd "M-s")
;;   (lambda () (interactive) (split-window-vertically) (other-window 1)))
;; (define-key robenkleene/leader-map (kbd "c") 'delete-window)
;; (define-key robenkleene/leader-map (kbd "o") 'delete-other-windows)

;; Window-Key Based
(define-key robenkleene/window-map
  (kbd "t")
  (lambda () (interactive) (make-frame) (other-frame 1)))
(define-key robenkleene/window-map
  (kbd "M-t")
  (lambda () (interactive) (make-frame) (other-frame 1)))
(define-key robenkleene/window-map (kbd "n") 'other-frame)
(define-key robenkleene/window-map (kbd "p")
  (lambda () (interactive) (other-frame -1)))
(define-key robenkleene/window-map (kbd "M-n") 'other-frame)
(define-key robenkleene/window-map (kbd "M-p")
  (lambda () (interactive) (split-window-horizontally) (other-frame -1)))
(define-key robenkleene/window-map (kbd "M-a") 'other-window)
(define-key robenkleene/window-map (kbd "M-W") 'other-window)
;; (define-key robenkleene/window-map (kbd "M-o") 'other-window)
(define-key robenkleene/window-map (kbd "q") 'delete-frame)
(define-key robenkleene/window-map (kbd "v")
  (lambda () (interactive) (split-window-horizontally) (other-window 1)))
(define-key robenkleene/window-map (kbd "M-v")
  (lambda () (interactive) (split-window-horizontally) (other-window 1)))
(define-key robenkleene/window-map (kbd "s")
  (lambda () (interactive) (split-window-vertically) (other-window 1)))
(define-key robenkleene/window-map (kbd "M-s")
  (lambda () (interactive) (split-window-vertically) (other-window 1)))
(define-key robenkleene/window-map (kbd "c") 'delete-window)
(define-key robenkleene/window-map (kbd "o") 'delete-other-windows)
(define-key robenkleene/window-map (kbd "<") 'shrink-window-horizontally)
(define-key robenkleene/window-map (kbd ">") 'enlarge-window-horizontally)
(define-key robenkleene/window-map (kbd "-") 'shrink-window)
(define-key robenkleene/window-map (kbd "+") 'enlarge-window)
(define-key robenkleene/window-map (kbd "=") 'balance-windows)

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
