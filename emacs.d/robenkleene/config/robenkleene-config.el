;;; robenkleene-config.el --- robenkleene-config
;;; Commentary:
;;; Code:

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

;; Mouse

;; Disable clicking to follow links
;; This interferes with using the mouse to select text, e.g., in terminal Emacs
;; in Blink Shell
(setq mouse-1-click-follows-link nil)
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

;; Automatically add view keys when viewing read only files
(setq view-read-only t)
(with-eval-after-load 'view
  (define-key view-mode-map (kbd "RET") nil)
  (define-key view-mode-map (kbd "n") nil)
  (define-key view-mode-map (kbd "p") nil)
  )

;; Repeat subsequent mark pops with `C-SPC'
(setq set-mark-command-repeat-pop t)

(provide 'robenkleene-config)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-config.el ends here
