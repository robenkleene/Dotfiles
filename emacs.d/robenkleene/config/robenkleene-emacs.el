;;; robenkleene-emacs.el --- robenkleene-emacs
;;; Commentary:
;;; Code:

;; Use bash for external scripts
(setq shell-file-name "bash")
(setq shell-command-switch "-ic")

;; Save temporary files to tmp directory
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Set path
(let ((paths-to-prepend
       '(
         "/Users/robenkleene/.nvm/versions/node/v0.12.2/bin/"
         )))
  (setenv "PATH" (mapconcat
                  'identity
                  (append paths-to-prepend
                          (list (getenv "PATH")))
                  ":"))
  (dolist (path-to-prepend paths-to-prepend)
    (add-to-list 'exec-path path-to-prepend))
  )

;; Automatically revert unmodified buffers
(global-auto-revert-mode t)

;; Only use hl-line-mode in specific modes
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)

;; Show trailing white space
(setq-default show-trailing-whitespace t)

;; Highlight Keywords
(add-hook 'prog-mode-hook 'robenkleene/highlight-keywords)

;; Enable Folding for Programming Modes
(add-hook 'prog-mode-hook 'hs-minor-mode)

;; Save recent file list
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(provide 'robenkleene-emacs)
;;; robenkleene-emacs.el ends here
