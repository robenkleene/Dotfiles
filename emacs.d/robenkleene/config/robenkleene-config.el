;;; robenkleene-config.el --- robenkleene-config
;;; Commentary:
;;; Code:

;; Without this, Emacs leaves an autosave file (e.g. `#foo.bar#') when quitting
;; without saving, this offers to delete those files too
(setq kill-buffer-delete-auto-save-files t)
;; Without this, Emacs will also add a backup file to the same directory as a
;; file being edit (backup files are the filename followed by a `~')
;; These files are to prevent issues when trying to save a new version of a
;; file, which necessarily requires deleting the original version
;; Note that this is different than autosave files, which are cleaned up
;; automatically when Emacs saves
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

;; Without this, Emacs does a bell for common actions like canceling a
;; minibuffer command
(setq ring-bell-function 'ignore)

;; Disable the builtin clipboard support
(setq select-enable-clipboard nil)

;; Set an environment variable to detect Emacs server
;; (Emacs server can persist across other shell environment settings [e.g.,
;; `TMUX' variable can no longer be trusted, so it needs to be handled
;; separately)
(if (and (boundp 'server-buffer-clients) server-buffer-clients)
    (setenv "EMACSSERVER" "1")
  )

;; Only copy to the clipboard if the region is active
(defun rk/safecopy (text &optional push)
  ;; Do nothing if the region isn't active so that other commands like
  ;; `kill-line', don't affect the system clipboard
  (if (use-region-p)
      (let (
            (process-connection-type nil)
            )
        (let ((proc (start-process "safecopy" nil "~/.bin/safecopy")))
          (unless (string))
          (process-send-string proc text)
          (process-send-eof proc)))
    )
  )
(setq interprogram-cut-function 'rk/safecopy)

;; Remove window chrome
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

;; Allow editing from multiple sources
(setq create-lockfiles nil)

;; Show cursor position
(column-number-mode)

;; Show trailing white space
(setq whitespace-style '(
                         face
                         tabs
                         tab-mark
                         ;; spaces
                         ;; space-mark
                         space-before-tab
                         space-after-tab
                         ))

;; Go to scratch buffer
(setq inhibit-startup-message t)

;; Don't require two spaces for sentences.
(setq sentence-end-double-space nil)

;; Overwrite region when pasting
(delete-selection-mode 1)

;; Don't split words when wrapping
(setq-default word-wrap t)

;; Wrap comments to 80 characters with `M-q'
(setq-default fill-column 80)

;; Show mouse hover in `modeline' instead of tool tips
(tooltip-mode -1)

;; Winner Mode
(winner-mode 1)

;; Save recent file list
(require 'recentf)
(recentf-mode t)

;; Remove window chrome
; (when (fboundp 'tool-bar-mode)
;   (tool-bar-mode -1))
; (when (fboundp 'scroll-bar-mode)
;   (scroll-bar-mode -1))
; (when (fboundp 'horizontal-scroll-bar-mode)
;   (horizontal-scroll-bar-mode -1))

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

;; Mouse

;; Disable clicking to follow links
;; This interferes with using the mouse to select text, e.g., in terminal Emacs
;; in Blink Shell
(setq mouse-1-click-follows-link nil)
;; Disable mouse highlighting
(setq mouse-highlight nil)

;; Don't prompt about killing processes when quitting
(setq confirm-kill-processes nil)

;; Automatically revert unmodified buffers
;; This was causing the cursor to jump randomly after saving
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)
;; Auto-revert more quickly
(setq auto-revert-interval 1)
;; Suppres `Reverting Buffer' message
;; This can be very noisy for some reason
(setq auto-revert-verbose nil)

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
;; Those commands are considered confusing without a visible mark
(setq disabled-command-function nil)

;; imenu
;; Automatically rescan, also prevents the `*Rescan*' menu item from appearing
(setq imenu-auto-rescan t)
;; Don't truncate imenu items
(setq imenu-max-item-length nil)
;; Don't use `.' as space replacement
(setq imenu-space-replacement nil)
;; Looks like `imenu-flatten' is coming soon as an option to flatten

;; Echo keystrokes to the echo area immediately
(setq echo-keystrokes 0.1)

;; Repeat subsequent mark pops with `C-SPC'
(setq set-mark-command-repeat-pop t)

;; Automatically accept redefinitions (without this it warns each time one is
;; applied)
(setq ad-redefinition-action 'accept)

;; Turn on built-in editorconfig
(editorconfig-mode 1)

;; (if window-system
;;     (load-theme 'modus-vivendi :no-confirm-loading)
;;   )
(load-theme 'modus-vivendi :no-confirm-loading)

(provide 'robenkleene-config)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-config.el ends here
