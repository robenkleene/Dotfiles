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

;; New Keys

;; Set these in such a way that other modes override, e.g., to make the bindings
;; access history in shell modes
(define-key robenkleene/bindings-minor-mode-map (kbd "M-n") 'robenkleene/next)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-p")
  'robenkleene/previous)

(define-key robenkleene/bindings-minor-mode-map (kbd "C-w")
  'robenkleene/kill-region-or-backward-word)

;; General

(define-key robenkleene/bindings-minor-mode-map (kbd "M-r")
  'robenkleene/reveal-in-finder)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-t")
  'robenkleene/open-terminal-window)
(define-key robenkleene/bindings-minor-mode-map (kbd "C-c w") 'toggle-truncate-lines)

;; Leader Key
(define-key robenkleene/bindings-minor-mode-map (kbd "M-W")
  robenkleene/window-map)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-a")
  robenkleene/window-map)
(define-key robenkleene/window-map (kbd "M-a") 'other-window)
(define-key robenkleene/window-map (kbd "M-A") (lambda () (interactive) (other-window -1)))
(define-key robenkleene/window-map (kbd "A") (lambda () (interactive) (other-window -1)))

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
(define-key robenkleene/window-map (kbd "M-W") 'other-window)
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
