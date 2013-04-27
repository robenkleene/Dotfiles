; -*-Emacs-Lisp-*-

;; Settings

;; Packages Management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives 
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Auto-Save Files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Start the emacs server if it isn't already running
(require 'server)
(unless (server-running-p)
  (server-start))

;; Quick Settings
(global-visual-line-mode t) ;; Don't split words when line wrapping
(setq visible-bell 1) ;; All the beeping is annoying
(scroll-bar-mode -1) ;; Disable scroolbars, use percentage
;; (setq scroll-preserve-screen-position t) ;; Cursor stays in same position on window
;; These two magic lines improve scrolling
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(delete-selection-mode 1)
(setq explicit-shell-file-name "/bin/bash") ;; zsh doesn't play nice with shell
(setq inhibit-startup-message t)

;; ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; Fuzzy matching
;; icomplete-mode
;; ido-mode style completion in describe-varable, etc...
(icomplete-mode t)
;; ido-ubiquitous
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)
;; With recentf
(defun rk-recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
(global-set-key (kbd "s-r") 'rk-recentf-ido-find-file)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Org-Mode
;; "s-[" org-metaleft
;; "s-S-[" org-shiftmetaleft



;; Keyboard mappings

;; (setq mac-command-modifier 'control)
;; (global-set-key (kbd "C-`") 'other-frame)
;; (global-set-key (kbd "C-~") 'previous-multiframe-window)
(global-set-key (kbd "s-k") 'kill-line) 
(global-set-key (kbd "s-y") 'yank)
;; Movement
(global-set-key (kbd "s-<left>") 'beginning-of-visual-line)
(global-set-key (kbd "s-<right>") 'move-end-of-line)
(global-set-key (kbd "s-<up>") 'beginning-of-buffer)
(global-set-key (kbd "s-<down>") 'end-of-buffer)
(global-set-key (kbd "<escape>") 'keyboard-quit)
;; Abort
(define-key minibuffer-local-map (kbd "<escape>") 'abort-recursive-edit) 
(global-set-key (kbd "s-b") 'ido-switch-buffer)
;; Windows
(global-set-key (kbd "C-`") 'other-window)
(global-set-key (kbd "C-~") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-'") 'other-window)
(global-set-key (kbd "C-\"") (lambda () (interactive) (other-window -1))) 
(global-set-key (kbd "C-s-w") 'delete-window)
(global-set-key (kbd "<C-s-268632087>") 'delete-window) ;; For some reason the above key mapping doesn't work and this one does
(global-set-key (kbd "C-S-s-w") 'delete-other-windows)


(define-key global-map (kbd "RET") 'newline-and-indent)
;; Complex Commands
(global-set-key (kbd "s-/") 'rk-comment-line-or-region)
(defun rk-comment-line-or-region ()
  (interactive)
  (if (use-region-p)
      (comment-or-uncomment-region (mark) (point))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))))
;; Window Functions
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


;; Look & Feel

;; Disable Toolbar
(if window-system
    (tool-bar-mode 0))
;; Window Positioning
(if window-system
    (add-to-list 'default-frame-alist '(top . 0))) ;; Re-positions window to the top fo the screen after loading, might become unnecessary if the emacs load sequence gets cleaned up

;; Theme
(load-theme 'wombat)
(set-cursor-color "#E57969")
(global-hl-line-mode t) ;; Highlight current line
;; (global-linum-mode 1) ;; Line numbers
;; Offset the number by two spaces to work around some weird fringe glitch
;; (setq linum-format "  %d ")
;; Cursor, Selection & Current Line
(set-face-attribute 'highlight nil :foreground 'unspecified :underline 'unspecified :background "#2F2F2F")
(set-face-attribute 'region nil :foreground "#ADD8E6" :background "#555555")


;; Packages

;; Smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-<S-SPC>") 'smex)
(global-set-key (kbd "s-'") 'smex)


;; Lisp
;; SLIME
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-to-list 'load-path "~/.emacs.d/manual/slime-2013-04-05") ;; Installed manually package install failed
(require 'slime)
;; (slime-setup)
(slime-setup '(slime-fancy))
;; Geiser
(setq geiser-active-implementations '(racket))
(setq geiser-racket-binary "/usr/local/bin/racket")

;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Parenedit
(show-paren-mode 1) ;; Built-in, highlights matching parentheses
;; (setq show-paren-style 'expression) ;; Highlights whole expression
;; Load Parenedit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
;; Additional Keyboard Bindings
(add-hook 'paredit-mode-hook
	  (lambda ()
	    (local-set-key (kbd "s-)") 'mark-sexp)))

;; Magit
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "#95E452")
     (set-face-foreground 'magit-diff-del "#E5796A")))
;; Magit Startup Helpers
(defun rk-magit-status-current-window () 
  "Magit in current window."
  (interactive)
  (progn (call-interactively 'magit-status) 
	 (delete-other-windows)))
(defun rk-focus ()
  "Focus on current frame."
  (select-frame-set-input-focus (selected-frame)))
(defun rk-magit-status-startup ()
  "Startup magit full frame with focus."
  (progn (rk-magit-status-current-window) (rk-focus)))

;; Multiple Cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")



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
