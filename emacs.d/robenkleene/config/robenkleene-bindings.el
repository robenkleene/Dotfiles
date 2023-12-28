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

(define-key rk/bindings-minor-mode-map (kbd "M-S-<down>") 'rk/duplicate-line-below)
(define-key rk/bindings-minor-mode-map (kbd "M-S-<up>") 'rk/duplicate-line-above)
(define-key rk/bindings-minor-mode-map (kbd "M-<down>") 'rk/move-line-down)
(define-key rk/bindings-minor-mode-map (kbd "M-<up>") 'rk/move-line-up)

;; History keys in isearch
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)
(defun rk/isearch-delete ()
  "Delete query."
  (interactive)
  (isearch-del-char most-positive-fixnum))
(define-key isearch-mode-map (kbd "M-<backspace>") 'rk/isearch-delete)
(define-key isearch-mode-map (kbd "M-DEL") 'rk/isearch-delete)

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

;; General
(define-key rk/bindings-minor-mode-map (kbd "M-r")
            'reveal-in-finder)
(define-key rk/bindings-minor-mode-map (kbd "C-c z")
            'z)
;; (define-key rk/bindings-minor-mode-map (kbd "M-t")
;;   'rk/open-terminal-window)
(define-key rk/bindings-minor-mode-map (kbd "C-c w") 'toggle-truncate-lines)
;; Not available in terminal
(define-key rk/bindings-minor-mode-map (kbd "C-c .") 'flyspell-auto-correct-word)
;; No default binding
(define-key rk/bindings-minor-mode-map (kbd "C-x :")
            'switch-to-minibuffer)
;; Other window
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
