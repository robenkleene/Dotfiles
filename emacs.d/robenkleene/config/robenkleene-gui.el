;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

(let ((paths-to-prepend
       (list
        (expand-file-name "~/.bin")
        (expand-file-name "~/.cargo/bin")
        (expand-file-name "~/.rubies/ruby-3.0.2/bin")
        (expand-file-name "~/.gem/ruby/3.0.2/bin")
        (expand-file-name "~/.nvm/versions/node/v21.6.1/bin")
        (expand-file-name "~/Library/Python/3.9/bin")
        (expand-file-name "~/.brew/bin")
        (expand-file-name "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin")
        (expand-file-name "/usr/local/bin")
        )
       ))
  (setenv "PATH" (mapconcat
                  'identity
                  (append paths-to-prepend
                          (list (getenv "PATH")))
                  ":"))
  (dolist (path-to-prepend paths-to-prepend)
    (add-to-list 'exec-path path-to-prepend))
  )
;; Make `rg' called from within Emacs use `ripgreprc'
(setenv "RIPGREP_CONFIG_PATH" (expand-file-name "~/.ripgreprc"))

;; Start the emacs server if it isn't already running and we're running in
;; window mode
;; (require 'server)
;; (if (display-graphic-p (selected-frame))
;;     (if (and (fboundp 'server-running-p)
;;              (not (server-running-p)))
;;         (server-start)))

;; Word spacing isn't great with Fira Code
;; (set-face-attribute 'default nil :font "Fira Code-12:Retina")
;; (setq-default line-spacing 0.2)
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-12:Regular")
;; (set-face-attribute 'default nil :font "Iosevka Term-13:Regular")
;; (setq-default line-spacing 0.2)
;; (set-face-attribute 'default nil :font "Menlo-12")
;; Doesn't support italics
;; (set-face-attribute 'default nil :font "Inconsolata-14")
;; Supports italics
;; (set-face-attribute 'default nil :font "SF Mono-12")
;; (set-face-attribute 'default nil :font "Hack-12")

;; Save window state
;; Don't restore window state because it makes it hard to enforce that Emacs
;; always starts up in the `~/.emacs.d/' directory otherwise, which it turns
;; makes Emacs often try to compile your entire hard drive.
(setq desktop-path `(,user-emacs-directory))
(setq desktop-dirname user-emacs-directory)
(setq desktop-save t)
;; Toggle save
;; (desktop-save-mode 1)

;; Set default window size
(setq-default initial-frame-alist
              '(
                (width . 80)
                (height . 48)
                ))
(setq-default default-frame-alist
              '(
                (width . 80)
                (height . 48)
                ))
;; Scroll bars
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
(add-to-list 'initial-frame-alist
             '(vertical-scroll-bars . nil))
;; Cursor color
(add-to-list 'default-frame-alist '(cursor-color . "#4BC840"))

;; Never use GUI dialog boxes
(setq use-dialog-box nil)

;; Hide line break indicator
(setf (cdr (assq 'continuation fringe-indicator-alist))
      '(nil nil))

(provide 'robenkleene-gui)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-gui.el ends here
