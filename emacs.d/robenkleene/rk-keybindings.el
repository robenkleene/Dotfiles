(provide 'rk-keybindings)

;; Editing
(global-set-key (kbd "s-k") 'kill-line) 
(global-set-key (kbd "s-y") 'yank)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Movement
(global-set-key (kbd "s-<left>") 'beginning-of-visual-line)
(global-set-key (kbd "s-<right>") 'move-end-of-line)
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
(global-set-key (kbd "s-<down>") 'end-of-buffer)
(global-set-key (kbd "<escape>") 'keyboard-quit)

;; Abort
(define-key minibuffer-local-map (kbd "<escape>") 'abort-recursive-edit) 

;; Windows
(global-set-key (kbd "C-`") 'other-window)
(global-set-key (kbd "C-~") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-'") 'other-window)
(global-set-key (kbd "C-\"") (lambda () (interactive) (other-window -1))) 
(global-set-key (kbd "C-s-w") 'delete-window)
(global-set-key (kbd "<C-s-268632087>") 'delete-window) ;; For some reason the above key mapping doesn't work and this one does
(global-set-key (kbd "C-S-s-w") 'delete-other-windows)



;; Custom Functions

;; Customizing Emacs
(global-set-key (kbd "C-s-e") 'rk-customize-emacs)
(global-set-key (kbd "<C-s-268632069>") 'rk-customize-emacs)
(defun rk-customize-emacs ()
  (interactive)
  (find-file "~/.emacs.d/robenkleene/robenkleene.el"))

;; Comments
(global-set-key (kbd "s-/") 'rk-comment-line-or-region)
(defun rk-comment-line-or-region ()
  (interactive)
  (if (use-region-p)
      (comment-or-uncomment-region (mark) (point))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))))

;; Window Management
(global-set-key (kbd "C-M-s-<left>") 'rk-set-frame-thin)
(global-set-key (kbd "C-M-s-<right>") 'rk-set-frame-wide)
(global-set-key (kbd "C-M-s-<up>") 'rk-set-frame-short)
(global-set-key (kbd "C-M-s-<down>") 'rk-set-frame-tall)
(defun rk-set-frame-short ()
  (interactive)
  (set-frame-height (selected-frame) 35))
(defun rk-set-frame-tall ()
  (interactive)
  (set-frame-height (selected-frame) 60))
(defun rk-set-frame-thin ()
  (interactive)
  (set-frame-width (selected-frame) 80))
(defun rk-set-frame-wide ()
  (interactive)
  (set-frame-width (selected-frame) 160))



;; This should only be run in window mode
;; (require 'assoc)
;; (defvar rk-frame-position-x-offset 20)
;; (defvar rk-frame-position-y-offset 20)
;; (defvar rk-frame-position-taskbar-height 30)
;; (defun rk-frame-position ()
;;   (let ((left (+ rk-frame-position-x-offset 
;;                  (or (frame-parameter nil 'left) 0)))
;;         (top (+ rk-frame-position-y-offset 
;;                 (or (frame-parameter nil 'top) 0))))
;;     (when (or (> (+ (frame-pixel-width) left) 
;;                  (display-pixel-width))
;;               (> (+ (frame-pixel-height) top 
;;                     rk-frame-position-taskbar-height)
;;                  (display-pixel-height)))
;;       (setq left 0 top 0))
;;     (aput 'default-frame-alist 'left left)
;;     (aput 'default-frame-alist 'top top)))

;; (aput 'default-frame-alist 'user-position t)
;; (add-hook 'before-make-frame-hook 'rk-frame-position)
