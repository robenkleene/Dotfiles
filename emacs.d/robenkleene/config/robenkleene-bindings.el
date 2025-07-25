;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; New Maps
(defvar rk/bindings-minor-mode-map (make-keymap))

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

(define-key rk/bindings-minor-mode-map (kbd "C-x `") 'eshell)
(define-key rk/bindings-minor-mode-map (kbd "C-x 4 `")
            'eshell-other-window)
(define-key rk/bindings-minor-mode-map (kbd "C-x t `")
            'eshell-other-tab)
(define-key rk/bindings-minor-mode-map (kbd "C-x 5 `")
            'eshell-other-frame)

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

;; Prefer the `regexp' versions of search and query replace, this is partially
;; because `C-M-%' isn't possible to type in a terminal
;; These use `global-set-key' so more specific minor modes can override them,
;; e.g., the minibuffer
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(define-key rk/bindings-minor-mode-map (kbd "C-M-s") 'isearch-forward)
(define-key rk/bindings-minor-mode-map (kbd "C-M-r") 'isearch-backward)
;; Swap query replace
(define-key rk/bindings-minor-mode-map (kbd "M-%")
            'query-replace-regexp)
(define-key rk/bindings-minor-mode-map (kbd "C-M-%") 'query-replace)

;; Z
(define-key rk/bindings-minor-mode-map (kbd "M-g z")
            'z)
(define-key rk/bindings-minor-mode-map (kbd "C-x 4 z")
            'z-other-window)
(define-key rk/bindings-minor-mode-map (kbd "C-x t z")
            'z-other-tab)
(define-key rk/bindings-minor-mode-map (kbd "C-x 5 z")
            'z-other-frame)

;; Misc
;; (define-key rk/bindings-minor-mode-map (kbd "C-x C-r")
;;             'recentf-open)
(define-key rk/bindings-minor-mode-map (kbd "C-x C-b")
            'ibuffer)
(define-key rk/bindings-minor-mode-map (kbd "C-x 4 C-b")
            'ibuffer-other-window)
(define-key rk/bindings-minor-mode-map (kbd "M-s g")
            'grep-shell-command)
(define-key rk/bindings-minor-mode-map (kbd "M-s f")
            'find-shell-command)
(define-key rk/bindings-minor-mode-map (kbd "C-x M-r")
            'remember)
(define-key rk/bindings-minor-mode-map (kbd "C-x M-n")
            'notes-find-file-other-window)
(define-key rk/bindings-minor-mode-map (kbd "C-g")
            'rk/keyboard-quit-dwim)
(define-key rk/bindings-minor-mode-map (kbd "M-<down>") 'rk/move-line-down)
(define-key rk/bindings-minor-mode-map (kbd "M-<up>") 'rk/move-line-up)

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
