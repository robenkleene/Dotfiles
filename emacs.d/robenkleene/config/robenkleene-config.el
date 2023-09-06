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

;; Mode line
;; Don't show `vc-mode' in mode-line
(setq-default mode-line-format (remove '(vc-mode vc-mode) mode-line-format))

;; Auto-Save
;; Disables auto-saving altogether
;; (setq auto-save-default nil)
;; Save to the original filename, instead of a separate auto-save file
;; (auto-save-visited-mode 1)
;; Automatically save every second
;; (setq auto-save-visited-interval 1)
;; This doesn't work for some reason
;; (add-function :after after-focus-change-function
;;               'rk/save-buffer-if-visiting-file)
;; Disable this, just look at the modeline instead
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

;; Suppress message when saving
;; (setq save-silently t)

;; Enable recursive minibuffers so `C-u M-! <command>' can be used when naming
;; files.
;; Try disabling recursive minibuffers, in practice it's really confusing
;; (setq enable-recursive-minibuffers t)

;; Add Line Numbers
;; Offset the number by two spaces to work around some weird fringe glitch
;; (setq linum-format "  %d ")
;; (global-display-line-numbers-mode 1)
;; Only show line numbers in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; Don't show line numbers in GUI mode because of that bug where the line with
;; the cursor sometimes gets offset slightly
;; (unless window-system
;;   (global-display-line-numbers-mode 1)
;;   ;; This looks janky
;;   ;; (add-hook 'prog-mode-hook 'display-line-numbers-mode)
;;   )

;; Show cursor position
(column-number-mode)

;; Show trailing white space
;; (setq-default show-trailing-whitespace t)
(add-hook 'prog-mode-hook (lambda () (setq-local show-trailing-whitespace t)))
(add-hook 'text-mode-hook (lambda () (setq-local show-trailing-whitespace t)))
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
(add-hook 'prog-mode-hook 'rk/highlight-keywords)

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
(define-advice shell-command-on-region (:after (&rest _) rk/shell-command-output)
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

;; Automatically jump to first help button
;; In practice, this is odd:
;; 1. Sometimes there isn't a button, so instead it jumps to the back button
;; 2. Sometimes one help points to another, and this only works for the first
;; help buffer loaded
;; (defadvice help-mode-finish
;;     (after rk/help-mode-finish () activate)
;;   (with-current-buffer (get-buffer-create "*Help*")
;;     (forward-button 1)
;;     )
;;   )
;; (add-hook 'occur-hook (lambda ()
;;                         (progn
;;                           (pop-to-buffer (get-buffer "*Occur*"))
;;                           (forward-line 1)
;;                           )
;;                         )
;;           )

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
;; This slows down startup and prompts macOS to install `gcc'!?
;; (ffap-bindings)

;; Only require `y' or `n'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight Matching parens
(show-paren-mode t)

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
;; (dolist (f '(try-expand-line try-expand-list))
;;   (setq hippie-expand-try-functions-list
;;         (remq f hippie-expand-try-functions-list)))

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

;; Allow project roots to be overridden with a `.project' file
(add-hook 'project-find-functions #'rk/project-override)

;; Automatically revert unmodified buffers
;; This was causing the cursor to jump randomly after saving
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)
;; Auto-revert more quickly
(setq auto-revert-interval 1)
;; Suppress message that happens every time a buffer gets reverted
;; (setq auto-revert-verbose nil)
;; Remove messages about saving when a file on disk has changed
(setq revert-without-query '(".*"))

;; Automatically enable disabled commands
(setq disabled-command-hook 'enable-me)

;; Don't wrap lines by default
(set-default 'truncate-lines t)
;; Wrap in text modes
(add-hook 'text-mode-hook (lambda ()
                            (set 'truncate-lines nil)
                            ))

;; Use `completion' if line is already indented
(setq tab-always-indent 'complete)

;; Always prefer newer `.el' file if there's an older `.elc' file
(setq load-prefer-newer t)

;; Don't try to parse long line
(global-so-long-mode)
;; Don't force long line files to read-only
;; Not sure why this doesn't work
;; (setq so-long-variable-overrides (delq 'buffer-read-only so-long-variable-overrides))
;; So instead just resetting the whole variable with that entry removed
(setq so-long-variable-overrides
      '((bidi-inhibit-bpa . t)
        (bidi-paragraph-direction . left-to-right)
        ;; (buffer-read-only . t)
        (global-hl-line-mode . nil)
        (line-move-visual . t)
        (show-paren-mode . nil)
        (truncate-lines . nil)
        (which-func-mode . nil)))

;; Enable all disabled commands (e.g., `upcase-region' and `downcase-region' are
;; disabled by default)
(setq disabled-command-function nil)

;; Highlight the current line
;; This makes it way easier to find the cursor in buffers with complicated
;; colors like `diff'
(global-hl-line-mode 1)

;; Make new buffers use `text-mode'
(setq-default major-mode 'text-mode)

;; Don't blink the cursor
;; (blink-cursor-mode 0)

(with-eval-after-load 'shell
  (define-key shell-mode-map (kbd "q") 'quit-window)
  )

;; Treat `-' and `_' as part of words for all modes except Emacs Lisp
;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (unless (derived-mode-p 'emacs-lisp-mode)
;;               (progn
;;                 (modify-syntax-entry ?_ "w")
;;                 (modify-syntax-entry ?- "w")
;;                 ))))
;; (add-hook 'text-mode-hook
;;           (lambda ()
;;             (modify-syntax-entry ?_ "w")
;;             (modify-syntax-entry ?- "w")
;;             ))

;; Abbrev
;; Not using these yet
;; (setq save-abbrevs nil)
;; Use abbreviations
;; (set-default 'abbrev-mode t)

;; Don't truncate imenu items
(setq imenu-max-item-length nil)

(provide 'robenkleene-config)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-config.el ends here
