;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; New Maps
(defvar rk/bindings-minor-mode-map (make-keymap))

;; Search & Replace

;; These use `global-set-key' so more specific minor modes can override them,
;; e.g., the minibuffer
;; Prefer the `regexp' versions of search and query replace, this is partially
;; because `C-M-%' isn't possible to type in a terminal
;; Toggle these off, here's the new strategy:
;; Use `C-s' to start an `isearch', then use `M-r' to switch it to a regular
;; expression. From `isearch', hit `M-%' to start a query replace. The query
;; replace will match the same mode as the `isearch' (so it will be `regex' if
;; you hit `M-r')
;; The above approach doesn't work for doing a replace in a region, because
;; starting the `isearch' moves the point
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(define-key rk/bindings-minor-mode-map (kbd "C-M-s") 'isearch-forward)
(define-key rk/bindings-minor-mode-map (kbd "C-M-r") 'isearch-backward)
;; Swap query replace
(define-key rk/bindings-minor-mode-map (kbd "M-%")
            'query-replace-regexp)
(define-key rk/bindings-minor-mode-map (kbd "C-M-%") 'query-replace)
;; Great for closing open buffers
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

;; Window Management `M-g M-c' is unbound, and it's used in the `*Completions*'
;; buffer to return to the minibuffer
(define-key rk/bindings-minor-mode-map (kbd "M-g M-c")
            'switch-to-minibuffer)
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

;; General
(define-key rk/bindings-minor-mode-map (kbd "C-x j")
            'dired-jump)
(defvar dired-jump-other-window-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "j") #'dired-jump)
    map))
(dolist (cmd '(dired-jump-other-window))
  (put cmd 'repeat-map 'dired-jump-other-window-repeat-map))

(define-key rk/bindings-minor-mode-map (kbd "C-x `") 'eshell-other-window)

;; Z
(define-key rk/bindings-minor-mode-map (kbd "M-g z")
            'z)
(define-key rk/bindings-minor-mode-map (kbd "C-x 4 z")
            'z-other-window)
(define-key rk/bindings-minor-mode-map (kbd "C-x 5 z")
            'z-other-frame)
(define-key rk/bindings-minor-mode-map (kbd "C-x t z")
            'z-other-tab)

(defvar previous-multiframe-window-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "O") #'previous-multiframe-window)
    (define-key map (kbd "o") #'other-window)
    map))
(dolist (cmd '(previous-multiframe-window))
  (put cmd 'repeat-map 'previous-multiframe-window-repeat-map))
(define-key rk/bindings-minor-mode-map (kbd "C-x O")
            'previous-multiframe-window)

;; Make undo repeatable, this is available by default, this adds `r' to redo
(defvar undo-only-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "u") #'undo-only)
    (define-key map (kbd "r") #'undo-redo)
    map))

(dolist (cmd '(undo))
  (put cmd 'repeat-map 'undo-only-repeat-map))
;; `undo' is bound by default, this makes the redo available
(define-key rk/bindings-minor-mode-map (kbd "C-x u")
            'undo-only)

;; Use `M-$' which works in GUI and terminal to either correct the word or add
;; it to the dictionary
;; Use `C-c $' to correct the word
;; (define-key rk/bindings-minor-mode-map (kbd "C-c .") 'flyspell-auto-correct-word)/

;; Mode
(define-minor-mode rk/bindings-minor-mode
  "My bindings."
  :init-value t
  :lighter nil
  :keymap 'rk/bindings-minor-mode-map)
(rk/bindings-minor-mode 1)

(defun rk/ensure-binding-priority (_file)
  "Ensure `bindings-minor-mode' always has priority."
  (unless (eq (caar minor-mode-map-alist) 'rk/bindings-minor-mode)
    (let ((new-keys
           (assq 'rk/bindings-minor-mode minor-mode-map-alist)))
      (assq-delete-all 'rk/bindings-minor-mode minor-mode-map-alist)
      (add-to-list 'minor-mode-map-alist new-keys))))
(add-hook 'after-load-functions 'rk/ensure-binding-priority)

(provide 'robenkleene-bindings)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-bindings.el ends here
