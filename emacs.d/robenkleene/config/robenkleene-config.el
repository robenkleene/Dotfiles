;;; robenkleene-config.el --- robenkleene-config
;;; Commentary:
;;; Code:

;; Use `bash' for external scripts
(setq shell-file-name "sh")
(setq shell-command-switch "-c")

;; Use `zsh'
(setq explicit-shell-file-name "/usr/local/bin/zsh")

;; Save temporary files to tmp directory The below command makes Emacs save
;; backups to a temporary directory, which is great except Emacs has no
;; interface for cleaning up the created backups, so if Emacs is creating these
;; files, it will just tell you about them, and how to recover them, but not
;; provide an interface for not recovering the file and preventing the message.
;; So until this interface is available, just disable the backups.
;; (setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
;; Just disable Emacs making backup files
(setq make-backup-files nil)

;; Auto-Save
;; Automatically save buffers every second
;; Disables auto-saving altogether
(setq auto-save-default nil)
;; Save to the original filename, instead of a separate auto-save file
(auto-save-visited-mode 1)
(setq auto-save-visited-interval 1)
;; This doesn't work for some reason
(add-function :after after-focus-change-function
              'robenkleene/save-buffer-if-visiting-file)
;; Just look at the modeline instead
;; (add-hook 'after-save-hook (lambda () (message "Saved")))

;; Re-enabling backups after losing data in a crash
(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.
(setq vc-make-backup-files t)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/")))
;; Hopefully this gets rid of the files with `#' around them
;; This doesn't fix all `#' files, this for lock files specified with
;; `.#filename'
;; Auto-save files are specified with `#filename#', it's unclear how
;; to organize those.
(setq create-lockfiles nil)

(setq desktop-path 'user-emacs-directory)
(setq desktop-dirname user-emacs-directory)
(setq desktop-save t)

;; Suppress message when saving
(setq save-silently t)

;; Enable recursive minibuffers so `C-u M-! <command>' can be used when naming
;; files.
(setq enable-recursive-minibuffers t)

;; Add Line Numbers
;; Note this is incompatible with git-gutter
;; (global-linum-mode t)
;; Offset the number by two spaces to work around some weird fringe glitch
;; (setq linum-format "  %d ")
(global-display-line-numbers-mode 1)
;; Show cursor position
(column-number-mode)

;; Show trailing white space
(setq-default show-trailing-whitespace t)
(add-hook 'prog-mode-hook 'whitespace-mode)
;; (global-whitespace-mode)
(setq whitespace-style (quote (
                               face
                               tabs
                               tab-mark
                               ;; spaces
                               ;; space-mark
                               space-before-tab
                               space-after-tab
                               )))

;; Highlight Keywords
(add-hook 'prog-mode-hook 'robenkleene/highlight-keywords)

;; Fill Column
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

;; Go to scratch buffer
(setq inhibit-startup-message t)

;; Editing & Navigation
;; (setq shift-select-mode nil)

;; Don't require two spaces for sentences.
(setq sentence-end-double-space nil)

;; Overwrite region when pasting
(delete-selection-mode 1)

;; Don't split words when wrapping
(setq-default word-wrap t)

;; Set `Shell Command Output' buffer to view only
(define-advice shell-command-on-region (:after (&rest _) robenkleene/shell-command-output)
  "Enable `view-mode' in `*Shell Command Output*' buffer."
  (let ((buffer (get-buffer "*Shell Command Output*")))
    (when (buffer-live-p buffer)
      (with-current-buffer buffer
        (view-mode)))))

;; Disable the bell completely, it's really annoying when the bell
;; sounds when doing a deterministic cancel (like `C-g')
(setq ring-bell-function 'ignore)

;; Wrap comments to 80 characters with `M-q'
(setq-default fill-column 80)

;; Show mouse hover in `modeline' instead of tool tips
(tooltip-mode -1)

;; Disable showing tooltips in the modeline, this conflicts with seeing flycheck
;; errors
;; (global-eldoc-mode -1)

;; Use shift arrow keys to switch windows
;; Note for this to work by default on OS X, these new keys need to be defined
;; in the Terminal profile:
;; `shift cursor up: \033[1;2A'
;; `shift cursor down: \033[1;2B'
;; (windmove-default-keybindings)

;; Winner Mode
;; Allows going to previous and next window configurations with `C-c left/right'
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Save recent file list
(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-items 100)
(setq recentf-max-saved-items 100)

;; Automatically select some types of buffers
(setq help-window-select t)
;; Automatically jump to first help button
;; In practice, this is odd:
;; 1. Sometimes there isn't a button, so instead it jumps to the back button
;; 2. Sometimes one help points to another, and this only works for the first
;; help buffer loaded
;; (defadvice help-mode-finish
;;     (after robenkleene/help-mode-finish () activate)
;;   (with-current-buffer (get-buffer-create "*Help*")
;;     (forward-button 1)
;;     )
;;   )

(add-hook 'occur-hook (lambda ()
                        (progn
                          (pop-to-buffer (get-buffer "*Occur*"))
                          (forward-line 1)
                          )
                        )
          )


;; Remove window chrome
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

;; Restore cursor position
(save-place-mode 1)

;; ffap
;; Replace `C-x C-f' with `find-file-at-point' version
(ffap-bindings)

;; Only require `y' or `n'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight Matching parens
(show-paren-mode 1)

(advice-add 'xref-find-definitions
            :before
            #'(lambda (identifier)
                (if (not (bound-and-true-p tags-file-name))
                    (let ((tags-file
                           (locate-dominating-file default-directory "TAGS")))
                      (when tags-file
                        (visit-tags-table tags-file)
                        )
                      )
                  )
                )
            )

;; Better Defaults
(setq-default indent-tabs-mode nil)
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;; Don't try to expand whole lines
;; Without this, extra parentheses can be inserted when performing
;; `hippie-expand'
(dolist (f '(try-expand-line try-expand-list))
  (setq hippie-expand-try-functions-list
        (remq f hippie-expand-try-functions-list)))

;; Spelling
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")
(add-hook 'text-mode-hook 'flyspell-mode)
;; This is way too noisy
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
(setq flyspell-issue-message-flag nil)
;; Don't prompt when saving a word to the dictionary
(setq ispell-silently-savep t)

;; Mouse
;; Double-click instead of single click to open links
;; This interferes with using the mouse to select text, e.g., in terminal Emacs
;; in Blink Shell
;; (setq mouse-1-click-follows-link 'double)
(setq mouse-1-click-follows-link nil)
;; To disable completely:
;; (setq mouse-1-click-follows-link nil)

;; Disable mouse highlighting
(setq mouse-highlight nil)

;; Automatically make shell scripts executable
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; Don't prompt about killing processes when quitting
(setq confirm-kill-processes nil)

;; Removes massive slow down with large `hg' repos
;; (setq vc-handled-backends '(Git))
;; Disable all backends, `git' shows an annoying message about following
;; symbolic link
;; (setq vc-handled-backends nil)
;; Try lighter alternatives to the above that keep `vc' features available:
(setq vc-follow-symlinks t)
;; `find-file-hook' can cause slow behavior
(remove-hook 'find-file-hook 'vc-find-file-hook)

;; Allow project roots to be overridden with a `.project' file
(add-hook 'project-find-functions #'robenkleene/project-override)

(add-hook 'find-file-hook 'robenkleene/z-add)
(add-hook 'dired-mode-hook 'robenkleene/z-add)

;; Automatically revert unmodified buffers
;; This was causing the cursor to jump randomly after saving
(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t)
;; Suppress message that happens every time a buffer gets reverted
(setq auto-revert-verbose nil)

;; Automatically enable disabled commands
(setq disabled-command-hook 'enable-me)

;; Don't wrap lines by default
(set-default 'truncate-lines t)

;; Don't show tab bar for one tab
(setq tab-bar-show 1)
;; Don't show close button
(setq tab-bar-close-button-show nil)
;; Hide plus button and other extras
(setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator))
;; Turn on tab bar (must be after setting options)
(tab-bar-mode)

;; Use `completion' if line is already indented
(setq tab-always-indent 'complete)

;; Make isearch wrap automatically
;; Prevents issue where you have to press backspace twice when
;; trying to remove the first character that fails a search
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)
(defadvice isearch-search (after robenkleene/isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'robenkleene/isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'robenkleene/isearch-no-fail)
    (ad-activate 'isearch-search)))

(provide 'robenkleene-config)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-config.el ends here
