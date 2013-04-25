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

;; ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
;; icomplete-mode
;; ido-mode style completion in describe-varable, etc...
(icomplete-mode t)

;; Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Keyboard mappings
(setq mac-command-modifier 'control)
(global-set-key (kbd "C-`") 'other-frame)
(global-set-key (kbd "C-~") 'previous-multiframe-window)


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

;; Window Functions
(defun rk-set-frame-tall ()
  "Make the frame tall."
  (interactive)
  (set-frame-size (selected-frame) 80 60))
(defun rk-set-frame-tall-and-wide ()
  "Make the frame tall and wide."
  (interactive)
  (set-frame-size (selected-frame) 160 60))
(defun rk-set-frame-normal ()
  "Make the frame normal."
  (interactive)
  (set-frame-size (selected-frame) 80 35))


;; Packages

;; Smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

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
