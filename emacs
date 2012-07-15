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

;; Load Zenburn
(load-theme 'zenburn t)
