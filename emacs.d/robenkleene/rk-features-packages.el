(provide 'rk-features-packages)

;; Evil-Mode
(rk-install-package-if-missing 'evil)
(require 'evil)
(evil-mode 1)
(setq evil-default-cursor t)
(blink-cursor-mode 0)
;; Disable insert mode key map
(setcdr evil-insert-state-map nil)
;; Re-enable esc
(define-key evil-insert-state-map [escape] 'evil-normal-state)
;; Evil Leader
(rk-install-package-if-missing 'evil-leader)
(require 'evil-leader)
(global-evil-leader-mode)
;; Evil Nerd Commenter
(rk-install-package-if-missing 'evil-nerd-commenter)
(evil-leader/set-key
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "\\" 'evilnc-comment-operator)
;; Evil Custom Bindings
(evil-leader/set-key
  "w" 'toggle-truncate-lines)
;; (define-key evil-normal-state-map "cow" 'toggle-truncate-lines)

;; Undefine Some Keys in Insert Mode
;; (defun evil-undefine ()
;;  (interactive)
;;  (let (evil-mode-map-alist)
;;    (call-interactively (key-binding (this-command-keys)))))
;; (define-key evil-insert-state-map (kbd "C-k") 'evil-undefine)

(rk-install-package-if-missing 'rainbow-delimiters)
(require 'rainbow-delimiters)

;; ido-ubiquitous
(rk-install-package-if-missing 'ido-ubiquitous)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;; smex
(rk-install-package-if-missing 'smex)
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-<S-SPC>") 'smex)
(global-set-key (kbd "s-'") 'smex)

;; Auto-complete
(rk-install-package-if-missing 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-auto-show-menu nil)
(setq ac-use-quick-help nil)
;; (global-set-key (kbd "C-/") 'auto-complete)

;; Autopair
(rk-install-package-if-missing 'autopair)
(require 'autopair)
(autopair-global-mode)

;; find-file-in-project
(rk-install-package-if-missing 'find-file-in-project)
(global-set-key (kbd "s-O") 'find-file-in-project)

;; Rainbow Mode
(rk-install-package-if-missing 'rainbow-mode)

;; Paredit
(rk-install-package-if-missing 'paredit)
(show-paren-mode 1) ;; Built-in, highlights matching parentheses
;; (setq show-paren-style 'expression) ;; Highlights whole expression
;; Load Paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "s-)") 'mark-sexp)
     ))

;; expand-region
(rk-install-package-if-missing 'expand-region)
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
