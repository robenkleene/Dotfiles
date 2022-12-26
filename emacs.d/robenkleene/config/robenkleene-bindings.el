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
;; Prefer the `regexp' versions of search and query replace, this is partially
;; because `C-M-%' isn't possible to type in a terminal
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-M-s") 'isearch-forward)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-M-r") 'isearch-backward)
;; Swap query replace
(define-key robenkleene/bindings-minor-mode-map (kbd "M-%")
  'query-replace-regexp)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-M-%") 'query-replace)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-S-<down>") 'robenkleene/duplicate-line-below)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-S-<up>") 'robenkleene/duplicate-line-above)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-<down>") 'robenkleene/move-line-down)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-<up>") 'robenkleene/move-line-up)

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

;; Improve default completion
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-c d <down-mouse-1>")
                #'robenkleene/describe-char-at-mouse-click)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-o") 'find-file)
(global-set-key (kbd "M-<tab>") 'completion-at-point)

;; New Keys

;; Set these in such a way that other modes override, e.g., to make the bindings
;; access history in shell modes
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'robenkleene/next)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-p")
;;   'robenkleene/previous)
;; Try using this instead, to difficult to keep track of all modes that populate
;; error list
;; Trying binding these on `text' and `prog' modes instead
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'next-error)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-p") 'previous-error)

;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-w")
;;   'robenkleene/kill-region-or-backward-word)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-w")
  'robenkleene/kill-region-or-window-map)
(defun robenkleene/kill-region-or-window-map ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, use `robenkleene/window-map'."
  (interactive)
  (if (use-region-p)
      (call-interactively 'kill-region)
    (set-transient-map robenkleene/window-map)
    )
  )

;; General
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-r")
;;   'robenkleene/reveal-in-finder)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-t")
;;   'robenkleene/open-terminal-window)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-c w") 'toggle-truncate-lines)

;; Window-Key Based
(define-key robenkleene/window-map
  (kbd "t")
  'tab-new)
(define-key robenkleene/window-map
  (kbd "M-t")
  'tab-new)
(define-key robenkleene/window-map (kbd "n") 'tab-next)
(define-key robenkleene/window-map (kbd "p")
  'tab-previous)
(define-key robenkleene/window-map (kbd "M-n") 'tab-next)
(define-key robenkleene/window-map (kbd "M-p")
  'tab-previous)
(define-key robenkleene/window-map (kbd "C-w") 'other-window)
(define-key robenkleene/window-map (kbd "w") 'other-window)
(define-key robenkleene/window-map (kbd "C-W") (lambda () (interactive) (other-window -1)))
(define-key robenkleene/window-map (kbd "W") (lambda () (interactive) (other-window -1)))
(define-key robenkleene/window-map (kbd "q") 'tab-close)
(define-key robenkleene/window-map (kbd "v")
  (lambda () (interactive) (split-window-horizontally) (other-window 1)))
(define-key robenkleene/window-map (kbd "M-v")
  (lambda () (interactive) (split-window-horizontally) (other-window 1)))
(define-key robenkleene/window-map (kbd "s")
  (lambda () (interactive) (split-window-vertically) (other-window 1)))
(define-key robenkleene/window-map (kbd "M-s")
  (lambda () (interactive) (split-window-vertically) (other-window 1)))
(define-key robenkleene/window-map (kbd "c")
  (lambda () (interactive)
    (condition-case nil (delete-window) (error (tab-close)))
    )
  )
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
