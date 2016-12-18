;;; robenkleene-config.el --- robenkleene-config
;;; Commentary:
;;; Code:

;; Use bash for external scripts
(setq shell-file-name "sh")
(setq shell-command-switch "-c")

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

;; Overwrite region when pasting
(delete-selection-mode 1)

;; Automatically revert unmodified buffers
(global-auto-revert-mode t)

;; Highlight Cursor Line
(global-hl-line-mode)

;; Add Line Numbers
;; Note this is incompatible with git-gutter
;; (global-linum-mode t)
;; Offset the number by two spaces to work around some weird fringe glitch
;; (setq linum-format "  %d ")

;; Show trailing white space
(setq-default show-trailing-whitespace t)

;; Highlight Keywords
(add-hook 'prog-mode-hook 'robenkleene/highlight-keywords)

;; Enable Folding for Programming Modes
(add-hook 'prog-mode-hook 'hs-minor-mode)

;; Go to scratch buffer
(setq inhibit-startup-message t)

;; Use shift arrow keys to switch windows
;; Note for this to work by default on OS X, these new keys need to be defined
;; in the Terminal profile:
;; `shift cursor up: \033[1;2A'
;; `shift cursor down: \033[1;2B'
(windmove-default-keybindings)

;; Winner Mode
;; Allows going to previous and next window configurations with `C-c left/right'
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Save recent file list
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Ido Mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; ffap
;; Replace `C-x C-f' with `find-file-at-point' version
(ffap-bindings)

(provide 'robenkleene-config)
;;; robenkleene-config.el ends here
