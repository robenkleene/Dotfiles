(provide 'rk-features-packages)

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

;; multiple-cursors
(rk-install-package-if-missing 'multiple-cursors)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; exec-path-from-shell
(rk-install-package-if-missing 'exec-path-from-shell)
;; This gives my path to emacs shell, it was causing an error on startup so temporarily disabled.
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))


;; Auto-complete
(rk-install-package-if-missing 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-auto-show-menu nil)
(setq ac-use-quick-help nil)
(global-set-key (kbd "C-/") 'auto-complete)

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
