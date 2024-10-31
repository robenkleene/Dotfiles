;;; robenkleene-config.el --- robenkleene-config
;;; Commentary:
;;; Code:

;; Use `bash' for external scripts
;; That was causing the `The kill is not a (set of) trees' when archiving in
;; `org-mode' with the `org-archive-subtree' command
;; (setq shell-file-name "sh")
;; (setq shell-command-switch "-c")

;; Use `zsh'
(setq explicit-shell-file-name "/usr/local/bin/zsh")

;; Without this, Emacs leaves an autosave file (e.g. `#foo.bar#') when quitting
;; without saving, this offers to delete those files too
(setq kill-buffer-delete-auto-save-files t)

;; Mode line
;; Don't show `vc-mode' in mode-line
(setq-default mode-line-format (remove '(vc-mode vc-mode) mode-line-format))

;; Allow editing from multiple sources
(setq create-lockfiles nil)

;; Automatically make shell scripts executable
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; Show cursor position
(column-number-mode)

;; Show trailing white space
;; (setq-default show-trailing-whitespace t)
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

;; Disable the initial echo area help message
(defun display-startup-echo-area-message ())
;; Go to scratch buffer
(setq inhibit-startup-message t)

;; Don't require two spaces for sentences.
(setq sentence-end-double-space nil)

;; Overwrite region when pasting
(delete-selection-mode 1)

;; Don't split words when wrapping
(setq-default word-wrap t)

;; Disable the bell completely, it's really annoying when the bell
;; sounds when doing a deterministic cancel (like `C-g')
(setq ring-bell-function 'ignore)

;; Wrap comments to 80 characters with `M-q'
(setq-default fill-column 80)

;; Show mouse hover in `modeline' instead of tool tips
(tooltip-mode -1)

;; Winner Mode
(winner-mode 1)

;; Save recent file list
(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-items 100)
(setq recentf-max-saved-items 100)

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

;; Automatically revert unmodified buffers
;; This was causing the cursor to jump randomly after saving
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)
;; Auto-revert more quickly
(setq auto-revert-interval 1)
;; Prevent the `Reverting buffer'
(setq auto-revert-verbose nil)

;; Automatically enable disabled commands
(setq disabled-command-hook 'enable-me)

;; Don't wrap lines by default
(set-default 'truncate-lines t)

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

;; Automatically rescan, also prevents the `*Rescan*' menu item from appearing
(setq imenu-auto-rescan t)
;; Don't truncate imenu items
(setq imenu-max-item-length nil)
;; Don't use `.' as space replacement
(setq imenu-space-replacement nil)
;; Looks like `imenu-flatten' is coming soon as an option to flatten

;; Echo keystrokes to the echo area immediately
(setq echo-keystrokes 0.1)

;; Make `remember-notes' use Fundamental mode
(setq remember-notes-initial-major-mode 'fundamental-mode)

;; Allow repeating some bindings like `C-x o' then `o' to keep switching frames
;; (repeat-mode 1)

;; Automatically add view keys when viewing read only files
(setq view-read-only t)
(with-eval-after-load 'view
  (define-key view-mode-map (kbd "RET") nil)
  (define-key view-mode-map (kbd "n") nil)
  (define-key view-mode-map (kbd "p") nil)
  )

;; Allow using tab to complete if the line is already properly indented, this
;; makes completion feel more consistent with completion in the minibuffer
;; It's not worth it trying to get this to work, e.g., `text-mode', and any C
;; derivative mode won't work with this setting because they have unique tab
;; behavior. Instead just use `M-tab' which is always bound to
;; `completion-at-point'
;; (setq tab-always-indent 'complete)

;; Use a file name that doesn't conflict with Vim `tags'
;; (setq tags-file-name "etags")

;; Increase the large file threshold, this helps when opening large tags files
(setq large-file-warning-threshold 1000000000)

;; Repeat subsequent mark pops with `C-SPC'
(setq set-mark-command-repeat-pop t)

;; Use `ripgrep' for grep
;; (setq grep-command "rg -n --no-heading "
;;       grep-use-null-device nil)

(provide 'robenkleene-config)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-config.el ends here
