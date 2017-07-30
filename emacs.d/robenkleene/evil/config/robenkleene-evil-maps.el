;;; robenkleene-evil-maps.el --- robenkleene-evil-maps
;;; Commentary:
;;; Code:

;; Disable insert mode key map
(setcdr evil-insert-state-map nil)
(setcdr evil-ex-completion-map nil)
(define-key evil-ex-completion-map "\C-g" 'abort-recursive-edit)
(define-key evil-ex-completion-map "\C-r" 'evil-paste-from-register)
(define-key evil-ex-completion-map "\C-n" #'next-complete-history-element)
(define-key evil-ex-completion-map [escape] 'abort-recursive-edit)
(define-key evil-ex-completion-map [up] 'previous-complete-history-element)
(define-key evil-ex-completion-map [down] 'next-complete-history-element)
(define-key evil-ex-completion-map [prior] 'previous-history-element)
(define-key evil-ex-completion-map [next] 'next-history-element)
(define-key evil-ex-completion-map [return] 'exit-minibuffer)
(define-key evil-ex-completion-map (kbd "RET") 'exit-minibuffer)

;; Re-enable `esc'
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;; Open Map
(defvar robenkleene/open-map (make-keymap))
(define-key robenkleene/open-map (kbd "i") (lambda() (interactive) (find-file "~/.emacs.d/robenkleene/robenkleene.el")))

;; Unimpaired Map
(defvar robenkleene/unimpaired-next-map (make-keymap))
(defvar robenkleene/unimpaired-previous-map (make-keymap))
(define-key robenkleene/unimpaired-next-map (kbd "q") 'next-error)
(define-key robenkleene/unimpaired-previous-map (kbd "q") 'previous-error)
(define-key robenkleene/unimpaired-next-map (kbd "b") 'next-buffer)
(define-key robenkleene/unimpaired-previous-map (kbd "b") 'previous-buffer)
(define-key robenkleene/unimpaired-next-map (kbd "c") 'git-gutter:next-hunk)
(define-key robenkleene/unimpaired-previous-map (kbd "c") 'git-gutter:previous-hunk)

;; Leader Map
(defvar robenkleene/leader-map (make-keymap))
(define-key robenkleene/leader-map (kbd "w") 'toggle-truncate-lines)
(define-key robenkleene/leader-map (kbd "T") 'robenkleene/open-terminal-window)
(define-key robenkleene/leader-map (kbd "t") 'eshell)
(define-key robenkleene/leader-map (kbd "R") 'robenkleene/reveal-in-finder)
(define-key robenkleene/leader-map (kbd "E") 'robenkleene/external-editor)
(define-key robenkleene/leader-map (kbd "o") robenkleene/open-map)
(define-key robenkleene/leader-map (kbd "b") 'ido-switch-buffer)

;; `evil-motion-state-map'
(define-key evil-motion-state-map (kbd "M-h") 'evil-window-left)
(define-key evil-motion-state-map (kbd "M-k") 'evil-window-up)
(define-key evil-motion-state-map (kbd "M-j") 'evil-window-down)
(define-key evil-motion-state-map (kbd "M-l") 'evil-window-right)
(define-key evil-motion-state-map (kbd "C-w t") 'make-frame-command)
(define-key evil-motion-state-map (kbd "C-w n") 'other-frame)
(define-key evil-motion-state-map (kbd "C-w p") '(lambda () (interactive) (other-frame -1)))
(define-key evil-motion-state-map (kbd "M-n") 'other-frame)
(define-key evil-motion-state-map (kbd "M-p") ' (lambda () (interactive) (other-frame -1)))
(define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)
(define-key evil-motion-state-map (kbd "C-w q") 'delete-frame)
(define-key evil-motion-state-map (kbd "[") robenkleene/unimpaired-previous-map)
(define-key evil-motion-state-map (kbd "]") robenkleene/unimpaired-next-map)
(define-key evil-motion-state-map "-" 'dired-jump)

(provide 'robenkleene-evil-maps)

;;; robenkleene-evil-maps.el ends here
