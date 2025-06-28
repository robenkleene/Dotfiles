;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

;; Path
(let ((paths-to-prepend
       (list
        (expand-file-name "~/.bin")
        (expand-file-name "~/.cargo/bin")
        (expand-file-name "~/.rubies/ruby-3.0.2/bin")
        (expand-file-name "~/.gem/ruby/3.0.2/bin")
        (expand-file-name "~/.nvm/versions/node/v21.6.1/bin")
        (expand-file-name "~/Library/Python/3.9/bin")
        (expand-file-name "~/.brew/bin")
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin"
        "/usr/local/bin"
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

;; Man Path
(let ((paths-to-prepend
       (list
        (expand-file-name "~/.man")
        (expand-file-name "~/.man-local")
        )
       ))
  (setenv "MANPATH" (mapconcat
                     'identity
                     (append paths-to-prepend
                             (list (getenv "MANPATH")))
                     ":"))
  )
;; Make `rg' called from within Emacs use `ripgreprc'
(setenv "RIPGREP_CONFIG_PATH" (expand-file-name "~/.ripgreprc"))

;; (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-13:Regular")
;; (set-face-attribute 'default nil :font "Menlo-13:Regular")
;; (set-face-attribute 'default nil :font "SF Mono-13:Regular")
(set-face-attribute 'default nil :font "Consolas-14:Regular")


;; Save window state
;; Don't restore window state because it makes it hard to enforce that Emacs
;; always starts up in the `~/.emacs.d/' directory otherwise, which it turns
;; makes Emacs often try to compile your entire hard drive.
(setq desktop-path `(,user-emacs-directory))
(setq desktop-dirname user-emacs-directory)
;; (setq desktop-save t)
;; Toggle save
;; (desktop-save-mode 1)

;; Scroll bars
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
(add-to-list 'initial-frame-alist
             '(vertical-scroll-bars . nil))

;; Use a bar cursor instead of a box
(setq-default cursor-type 'bar)

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
