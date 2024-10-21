;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; New Maps
(defvar rk/bindings-minor-mode-map (make-keymap))

;; Search & Replace

;; The default `completion-at-point' key, `C-M-i', doesn't work in terminal
;; emacs, but it resolves to `M-<tab>', which is unbound. Bind `M-<tab>' to
;; `completion-at-point' so that same binding works in terminal emacs
(global-set-key (kbd "M-<tab>") 'completion-at-point)

;; Window Management `M-g M-c' is unbound, and it's used in the `*Completions*'
;; buffer to return to the minibuffer
(define-key rk/bindings-minor-mode-map (kbd "M-g M-c")
            'switch-to-minibuffer)
;; The default binding for this, `C-M-.' isn't supported in terminal
(define-key rk/bindings-minor-mode-map (kbd "M-g .")
            'xref-find-apropos)

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
(define-key rk/bindings-minor-mode-map (kbd "M-s g")
            'grep)
(define-key rk/bindings-minor-mode-map (kbd "M-s f")
            'find-shell-command-dired)

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
