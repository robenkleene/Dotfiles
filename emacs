; -*-Emacs-Lisp-*-

;; Marmalade
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; List of packages installed via package.el
;;
;; starter-kit
;; markdown-mode
;; zenburn-theme


;; Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Markdown Mode
     (autoload 'markdown-mode "markdown-mode"
        "Major mode for editing Markdown files" t)
     (setq auto-mode-alist
        (cons '("\\.md" . markdown-mode) auto-mode-alist))


;; Look & Feel
;; Load Zenburn
(load-theme 'zenburn t)
(defun set-frame-size ()
                  (add-to-list 'default-frame-alist '(left   . 65))
                  (add-to-list 'default-frame-alist '(top    . 0))
                  (add-to-list 'default-frame-alist '(height . 60))
                  (add-to-list 'default-frame-alist '(width  . 80))
)
(when window-system
    (set-face-attribute 'default nil :family "Menlo" :height 120 :weight 'normal)
    (set-frame-size)
    (add-hook 'before-make-frame-hook
              #'(lambda () (set-frame-size)))
    )

;; Start the emacs server if it isn't already running
(require 'server)
(unless (server-running-p)
  (server-start))
