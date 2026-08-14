;;; robenkleene-gui.el --- robenkleene-gui
;;; Commentary:
;;; Code:

;; Do nothing if the region isn't active so that other commands like
;; `kill-line', don't affect the system clipboard
(defun rk/safecopy (text &optional _push)
  (when (use-region-p)
    (gui-select-text text))
  )
;; Replaces the default `interprogram-cut-function' of `gui-select-text'
(setq interprogram-cut-function 'rk/safecopy)
;; Replaces the default `interprogram-paste-function' of `gui-selection-value',
;; so `yank' (`C-y') only ever reads the kill ring.
(setq interprogram-paste-function nil)
;; `clipboard-yank' only rebinds `select-enable-clipboard', so it's inert once
;; `interprogram-paste-function' is nil, restore it for this command alone.
(defun rk/clipboard-yank ()
  "Insert the system clipboard, even though `C-y' can't."
  (interactive "*")
  (let ((interprogram-paste-function 'gui-selection-value))
    (clipboard-yank))
  )

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
(set-face-attribute 'default nil :font "SF Mono-13:Medium")
;; Consolas is shifted slightly-upwards in Emacs, this is a problem originating
;; in the font file itself
;; (set-face-attribute 'default nil :font "Consolas-14:Regular")
;; (set-face-attribute 'default nil :font "Berkeley Mono-14:Regular")

;; Give just a bit of additional padding
(setq-default line-spacing 0.1)

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
