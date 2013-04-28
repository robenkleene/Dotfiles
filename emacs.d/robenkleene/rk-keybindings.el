(provide 'rk-keybindings)

;; OS X Style
(defvar rk-osx-minor-mode-map (make-keymap) "rk-osx-minor-mode map keymap.")
(define-key rk-osx-minor-mode-map (kbd "s-<left>") 'beginning-of-visual-line)
(define-key rk-osx-minor-mode-map (kbd "s-<right>") 'move-end-of-line)
(define-key rk-osx-minor-mode-map (kbd "s-<up>") 'beginning-of-buffer)
(define-key rk-osx-minor-mode-map (kbd "s-<down>") 'end-of-buffer)
(define-key rk-osx-minor-mode-map (kbd "M-<left>") 'left-word)
(define-key rk-osx-minor-mode-map (kbd "M-<right>") 'right-word)
(define-key rk-osx-minor-mode-map (kbd "M-S-<left>") nil)
(define-key rk-osx-minor-mode-map (kbd "M-S-<right>") nil)
(define-minor-mode rk-osx-minor-mode
  "Behave like OS X."
  :global t)
(rk-osx-minor-mode 1)

;; Windows & Buffers
(defvar rk-wm-minor-mode-map (make-keymap) "rk-wm-minor-mode map keymap.")
(define-key rk-wm-minor-mode-map (kbd "C-`") 'other-window)
(define-key rk-wm-minor-mode-map (kbd "C-~") (lambda () (interactive) (other-window -1)))
(define-key rk-wm-minor-mode-map (kbd "C-'") 'other-window)
(define-key rk-wm-minor-mode-map (kbd "C-\"") (lambda () (interactive) (other-window -1))) 
(define-key rk-wm-minor-mode-map (kbd "C-w") 'delete-window)
(define-key rk-wm-minor-mode-map (kbd "C-S-w") 'delete-other-windows)
(define-key rk-wm-minor-mode-map (kbd "s-{") 'previous-buffer) ; Tab-switching Style
(define-key rk-wm-minor-mode-map (kbd "s-}") 'next-buffer)
(define-key rk-wm-minor-mode-map (kbd "C-s-<left>") 'previous-buffer) ;; Xcode Style
(define-key rk-wm-minor-mode-map (kbd "C-s-<right>") 'next-buffer)
(define-minor-mode rk-wm-minor-mode
  "Window management minor mode."
  :global t)
(rk-wm-minor-mode 1)


;; Editing
(global-set-key (kbd "s-k") 'kill-line) 
(global-set-key (kbd "s-y") 'yank)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "s-]") 'indent-for-tab-command)
(global-set-key (kbd "s-[") 'indent-for-tab-command)

(global-set-key (kbd "<escape>") 'keyboard-quit)

;; Abort
(define-key minibuffer-local-map (kbd "<escape>") 'abort-recursive-edit) 

;; Custom Functions

;; Customizing Emacs
(global-set-key (kbd "s-E") 'rk-customize-emacs)
(global-set-key (kbd "<C-s-268632069>") 'rk-customize-emacs)
(defun rk-customize-emacs ()
  (interactive)
  (find-file "~/.emacs.d/robenkleene/robenkleene.el"))

;; Text Directory
(global-set-key (kbd "s-T") 'rk-text-directory)
(defun rk-text-directory ()
  (interactive)
  (find-file "~/Dropbox/Text/Scratch.md"))

;; Comments
(global-set-key (kbd "s-/") 'rk-comment-line-or-region)
(defun rk-comment-line-or-region ()
  (interactive)
  (if (use-region-p)
      (if (< (point) (mark))
	  (comment-or-uncomment-region (point) (mark))
	(comment-or-uncomment-region (mark) (point)))
    (comment-or-uncomment-region (line-beginning-position)
				 (line-end-position))))

;; snpt
(global-set-key (kbd "C-s-s") 'rk-snpt)
(global-set-key (kbd "<C-s-268632083>") 'rk-snpt)
(defun rk-snpt () 
  (interactive)
  (let ((command 
	 (if (string-match "[.]"
			   (buffer-substring
			    (line-beginning-position)
			    (line-end-position)))
	     "snpt"
	   (concat "snpt -l " (file-name-extension buffer-file-name))
	   )
	 ))
    (shell-command-on-region
     (line-beginning-position)
     (line-end-position)
     command t t)
    ))


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
