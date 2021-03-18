;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; Add a second leader key
;; (define-key key-translation-map (kbd "M-o") (kbd "C-c"))
;; These should be added only for terminal modes
;; (define-key key-translation-map (kbd "<M-up>") (kbd "M-p"))
;; (define-key key-translation-map (kbd "<M-down>") (kbd "M-n"))

;; Automatically switch focus to new splits
(global-set-key "\C-x2" (lambda ()
                          (interactive)
                          (split-window-vertically)
                          (other-window 1)))
(global-set-key "\C-x3" (lambda ()
                          (interactive)
                          (split-window-horizontally)
                          (other-window 1)))

;; Set these in such a way that other modes override, e.g., to make the bindings
;; access history in shell modes
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)
(global-set-key (kbd "M-s-v")
                (lambda () (interactive)
                  (split-window-horizontally) (other-window 1)))
(global-set-key (kbd "M-s-s")
                (lambda () (interactive)
                  (split-window-vertically) (other-window 1)))
(global-set-key (kbd "M-s-c") 'delete-window)
(global-set-key (kbd "M-s-o") 'delete-other-windows)
(global-set-key (kbd "M-s-.") 'other-window)
(global-set-key (kbd "M-s->") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "M-s-<down>") 'windmove-down)
(global-set-key (kbd "M-s-<up>") 'windmove-up)
(global-set-key (kbd "M-s-<left>") 'windmove-left)
(global-set-key (kbd "M-s-<right>") 'windmove-right)
(global-set-key (kbd "C-s-e") 'forward-sentence)
(global-set-key (kbd "C-s-a") 'backward-sentence)


;; History keys in isearch
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)

;; Better Defaults
;; (global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-r") 'robenkleene/ido-recent-find-file)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-%") 'query-replace)
(global-set-key (kbd "C-w") 'robenkleene/kill-region-or-backward-word)
(global-set-key (kbd "C-x c") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-h C-f") 'find-function)

;; These commands are part of a general strategy of mapping the command key to
;; the control key in Emacs
(global-set-key (kbd "<C-up>") 'beginning-of-buffer)
(global-set-key (kbd "<C-down>") 'end-of-buffer)
(global-set-key (kbd "<C-left>") 'move-beginning-of-line)
(global-set-key (kbd "<C-right>") 'move-end-of-line)

(global-set-key (kbd "<M-S-down>") 'robenkleene/duplicate-line-below)
(global-set-key (kbd "<M-S-up>") 'robenkleene/duplicate-line-above)
(global-set-key (kbd "<C-s-left>") 'winner-undo)
(global-set-key (kbd "<C-s-right>") 'winner-redo)

;; Maps
(defvar robenkleene/bindings-minor-mode-map (make-keymap))
(defvar robenkleene/leader-map (make-keymap))

;; General
(define-key robenkleene/bindings-minor-mode-map (kbd "C-x C-o") 'other-window)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-i") 'imenu)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-i") 'next-buffer)
;; (define-key robenkleene/bindings-minor-mode-map (kbd "M-o") 'previous-buffer)

(define-key robenkleene/bindings-minor-mode-map (kbd "M-o")
  'robenkleene/ido-quick-open)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-g")
  'robenkleene/ido-quick-developer)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-e")
  'robenkleene/ido-recursive-find-file)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-c")
  'robenkleene/ido-recursive-find-dir)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-z")
  'robenkleene/ido-z)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-r")
  'robenkleene/reveal-in-finder)
;; Leader Map
;; (define-key robenkleene/bindings-minor-mode-map (kbd "C-c")
;;   robenkleene/leader-map)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-a")
  robenkleene/leader-map)
;; Mac-like save in terminal and GUI
;; (define-key robenkleene/bindings-minor-mode-map (kbd "s-s") 'save-buffer)
(define-key robenkleene/bindings-minor-mode-map
  (kbd "C-x s-s") 'save-buffer)
(define-key robenkleene/bindings-minor-mode-map (kbd "M-l")
  'robenkleene/urls-open)
(if window-system
    (progn
      ;; This results in a quick search being automatically triggered on startup
      ;; in terminal Emacs.
      (define-key robenkleene/bindings-minor-mode-map (kbd "M-O")
        'robenkleene/ido-quick-open-file)
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
;; (global-set-key (kbd "M-]") 'forward-paragraph)
;; (global-set-key (kbd "M-[") 'backward-paragraph)

;; Leader map
;; (define-key robenkleene/leader-map (kbd "w") 'visual-line-mode)
(define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
;; (define-key robenkleene/leader-map (kbd "t") 'robenkleene/other-window-shell)
(define-key robenkleene/leader-map (kbd "`") 'robenkleene/other-window-eshell)
(define-key robenkleene/leader-map (kbd "z") 'robenkleene/ido-bookmark-jump)
(define-key robenkleene/leader-map (kbd "i") 'imenu)
;; (define-key robenkleene/leader-map (kbd "i") 'next-buffer)
;; (define-key robenkleene/leader-map (kbd "o") 'previous-buffer)
(define-key robenkleene/leader-map (kbd "l") 'occur)
;; (define-key robenkleene/leader-map (kbd "o i") 'robenkleene/edit-init)
(define-key robenkleene/leader-map (kbd "M-e")
  'robenkleene/ido-recursive-insert-file)
(define-key robenkleene/leader-map (kbd "M-c")
  'robenkleene/ido-recursive-insert-dir)
(define-key robenkleene/leader-map (kbd "g M-e")
  'robenkleene/ido-source-control-recursive-find-file)
(define-key robenkleene/leader-map (kbd "g M-c")
  'robenkleene/ido-source-control-recursive-find-dir)
(define-key robenkleene/leader-map (kbd "g a")
  'robenkleene/rg-source-control)
;; (define-key robenkleene/leader-map (kbd "a") 'robenkleene/archive)
(define-key robenkleene/leader-map (kbd "a") 'robenkleene/rg)
(define-key robenkleene/leader-map (kbd "u") 'robenkleene/new-empty)
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
;; (define-key robenkleene/leader-map (kbd "c")
;;   'robenkleene/title-case)
(define-key robenkleene/leader-map (kbd "*")
  'isearch-forward-symbol-at-point)
(define-key robenkleene/leader-map (kbd "b")
  'ido-switch-buffer)

;; Window Management
(define-key robenkleene/leader-map (kbd "M-a") 'other-window)
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
  t
  nil
  'robenkleene/bindings-minor-mode-map)
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
