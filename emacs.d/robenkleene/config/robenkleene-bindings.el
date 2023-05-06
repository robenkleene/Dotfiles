;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; New Maps
(defvar rk/bindings-minor-mode-map (make-keymap))
(defvar rk/leader-map (make-keymap))
(defvar rk/window-map (make-keymap))

;; Search & Replace

;; These use `global-set-key' so more specific minor modes can override them,
;; e.g., the minibuffer
;; Prefer the `regexp' versions of search and query replace, this is partially
;; because `C-M-%' isn't possible to type in a terminal
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(define-key rk/bindings-minor-mode-map (kbd "C-M-s") 'isearch-forward)
(define-key rk/bindings-minor-mode-map (kbd "C-M-r") 'isearch-backward)
;; Swap query replace
(define-key rk/bindings-minor-mode-map (kbd "M-%")
  'query-replace-regexp)
(define-key rk/bindings-minor-mode-map (kbd "C-M-%") 'query-replace)
;; (define-key rk/bindings-minor-mode-map (kbd "M-S-<down>") 'rk/duplicate-line-below)
;; (define-key rk/bindings-minor-mode-map (kbd "M-S-<up>") 'rk/duplicate-line-above)
;; (define-key rk/bindings-minor-mode-map (kbd "M-<down>") 'rk/move-line-down)
;; (define-key rk/bindings-minor-mode-map (kbd "M-<up>") 'rk/move-line-up)

;; History keys in isearch
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)

;; Window Management

;; Automatically switch focus to new splits
(define-key rk/bindings-minor-mode-map "\C-x2" (lambda ()
                                                          (interactive)
                                                          (split-window-vertically)
                                                          (other-window 1)))
(define-key rk/bindings-minor-mode-map "\C-x3"
  (lambda ()
    (interactive)
    (split-window-horizontally)
    (other-window 1)))

;; Improve default completion
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-c d <down-mouse-1>")
                #'rk/describe-char-at-mouse-click)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-o") 'find-file)
(global-set-key (kbd "M-<tab>") 'completion-at-point)
;; Always allow meta up and down to match M-p and M-n
;; This breaks `org-mode' bindings to move an item up or down
;; (define-key key-translation-map (kbd "M-<up>") (kbd "M-p"))
;; (define-key key-translation-map (kbd "M-<down>") (kbd "M-n"))
;; (define-key input-decode-map (kbd "M-<up>") (kbd "M-p"))
;; (define-key input-decode-map (kbd "M-<down>") (kbd "M-n"))

;; New Keys

;; Set these in such a way that other modes override, e.g., to make the bindings
;; access history in shell modes
;; (define-key rk/bindings-minor-mode-map (kbd "M-n") 'rk/next)
;; (define-key rk/bindings-minor-mode-map (kbd "M-p")
;;   'rk/previous)
;; Try using this instead, to difficult to keep track of all modes that populate
;; error list
;; Trying binding these on `text' and `prog' modes instead
;; (define-key rk/bindings-minor-mode-map (kbd "M-n") 'next-error)
;; (define-key rk/bindings-minor-mode-map (kbd "M-p") 'previous-error)

;; (define-key rk/bindings-minor-mode-map (kbd "C-w")
;;   'rk/kill-region-or-backward-word)
(define-key rk/bindings-minor-mode-map (kbd "C-w")
  'rk/kill-region-or-window-map)

;; General
(define-key rk/bindings-minor-mode-map (kbd "M-r")
  'reveal-in-finder)
;; (define-key rk/bindings-minor-mode-map (kbd "M-t")
;;   'rk/open-terminal-window)
(define-key rk/bindings-minor-mode-map (kbd "C-c w") 'toggle-truncate-lines)
(define-key rk/bindings-minor-mode-map (kbd "C-c `") 'eshell)
(define-key rk/bindings-minor-mode-map (kbd "C-`") 'eshell)
;; (define-key rk/bindings-minor-mode-map (kbd "C-c s") 'rk/sgit-push-text-all)

;; Window-Key Based
(define-key rk/window-map
  (kbd "t")
  'tab-new)
(define-key rk/window-map
  (kbd "M-t")
  'tab-new)
(define-key rk/window-map (kbd "n") 'tab-next)
(define-key rk/window-map (kbd "p")
  'tab-previous)
(define-key rk/window-map (kbd "M-n") 'tab-next)
(define-key rk/window-map (kbd "M-p")
  'tab-previous)
(define-key rk/window-map (kbd "C-w") 'other-window)
(define-key rk/window-map (kbd "w") 'other-window)
(define-key rk/window-map (kbd ":") 'switch-to-minibuffer)
;; For some reason this also overwrites `C-w C-w'
;; (define-key rk/window-map (kbd "C-W") (lambda () (interactive) (other-window -1)))
(define-key rk/window-map (kbd "W") 'rk/other-window-reverse)
(define-key rk/window-map (kbd "q") 'tab-close)
(define-key rk/window-map (kbd "v") 'rk/split-horizontal)
(define-key rk/window-map (kbd "s") 'rk/split-vertical)
(define-key rk/window-map (kbd "c")
  (lambda () (interactive)
    (condition-case nil (delete-window) (error (tab-close)))
    )
  )
(define-key rk/window-map (kbd "o") 'delete-other-windows)
(define-key rk/window-map (kbd "<") 'shrink-window-horizontally)
(define-key rk/window-map (kbd ">") 'enlarge-window-horizontally)
(define-key rk/window-map (kbd "-") 'shrink-window)
(define-key rk/window-map (kbd "+") 'enlarge-window)
(define-key rk/window-map (kbd "=") 'balance-windows)
(define-key rk/window-map (kbd "C-o") 'winner-undo)
(define-key rk/window-map (kbd "C-i") 'winner-redo)

;; Use functions instead of lambdas for these because they're more compatible
;; with `post-command-hook', e.g., for Pulsar
(defun rk/other-window-reverse (&optional arg)
  (interactive)
  (other-window -1)
  )

(defun rk/split-horizontal (&optional arg)
  (interactive)
  (split-window-horizontally)
  (call-interactively 'other-window)
  )

(defun rk/split-vertical (&optional arg)
  (interactive)
  (split-window-vertically)
  (call-interactively 'other-window)
  )

;; Mode
(define-minor-mode rk/bindings-minor-mode
  "My bindings."
  :init-value t
  :lighter nil
  :keymap 'rk/bindings-minor-mode-map)
(rk/bindings-minor-mode 1)

(add-hook 'after-load-functions 'rk/ensure-binding-priority)

(defun rk/ensure-binding-priority (_file)
  "Ensure `bindings-minor-mode' always has priority."
  (unless (eq (caar minor-mode-map-alist) 'rk/bindings-minor-mode)
    (let ((new-keys
           (assq 'rk/bindings-minor-mode minor-mode-map-alist)))
      (assq-delete-all 'rk/bindings-minor-mode minor-mode-map-alist)
      (add-to-list 'minor-mode-map-alist new-keys))))

(provide 'robenkleene-bindings)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-bindings.el ends here
