;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package evil
  :commands (evil-mode)
  :init
  (setq
   evil-normal-state-tag
   (propertize " N " 'face '((:background "purple3" :foreground "white")))
   evil-operator-state-tag
   (propertize " O " 'face '((:background "purple3" :foreground "white")))
   evil-insert-state-tag
   (propertize " I " 'face '((:background "RoyalBlue" :foreground "white")))
   evil-emacs-state-tag
   (propertize " E " 'face '((:background "RoyalBlue" :foreground "white")))
   evil-motion-state-tag
   (propertize " M " 'face '((:background "purple3" :foreground "white")))
   evil-visual-block-tag
   (propertize " V (B) " 'face '((:background "purple3" :foreground "white")))
   evil-visual-char-tag
   (propertize " V (C) " 'face '((:background "purple3" :foreground "white")))
   evil-visual-line-tag
   (propertize " V (L) " 'face '((:background "purple3" :foreground "white")))
   evil-visual-screen-line-tag
   (propertize " V (SL) " 'face '((:background "purple3" :foreground "white")))
   ;; If this is set, it'll be used instead of the more specific visual tags above
   ;; The above ones caused an issue where using the mouse to drag a selection
   ;; sometimes would cause the indicator to disappear
   evil-visual-state-tag
   (propertize " V " 'face '((:background "purple3" :foreground "white")))
   evil-replace-state-tag
   (propertize " R " 'face '((:background "purple3" :foreground "white")))
   )

  (with-eval-after-load 'evil
    ;; Use symbols instead of words, so evil treats `-' and `_' as part of a word
    ;; Disabling this because it causes move by word to jump over paths, e.g.,
    ;; `/this/is/a/path'
    ;; (defalias #'forward-evil-word #'forward-evil-symbol)
    (setq-default evil-symbol-word-search t))

  ;; Prevent cutting when doing a visual paste, which breaks visual paste
  ;; completely when system clipboard integration is present because the yank
  ;; overwrites what's intended to paste
  (setq-default evil-kill-on-visual-paste nil)

  ;; Don't show last ex command or search by default
  (setq-default evil-want-empty-ex-last-command nil)

  ;; Just use default Emacs in insert mode
  (setq evil-disable-insert-state-bindings t)

  ;; Persist search highlighting
  (setq evil-search-module 'evil-search)

  ;; Center search results
  (advice-add 'evil-ex-search-next :after
              (lambda (&rest x) (evil-scroll-line-to-center (line-number-at-pos))))
  (advice-add 'evil-ex-search-previous :after
              (lambda (&rest x) (evil-scroll-line-to-center (line-number-at-pos))))

  ;; Disable smart case
  ;; (setq evil-ex-search-case 'sensitive)

  ;; Make `Y' yank to eol
  (setq evil-want-Y-yank-to-eol t)

  ;; Don't let anything override Evil
  ;; Set initial state
  ;; (setq evil-default-state 'emacs)
  ;; (setq evil-default-state 'insert)
  (setq evil-default-state 'motion)

  (setq evil-overriding-maps nil
        evil-intercept-maps nil
        evil-pending-intercept-maps nil
        evil-pending-overriding-maps nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  ;; Disabling all Evil "smart" features
  ;; subvert evil-operation.el overrides (dired, ibuffer etc.)
  (advice-add 'evil-make-overriding-map :override #'ignore)
  (advice-add 'evil-make-intercept-map :override #'ignore)
  (advice-add 'evil-add-hjkl-bindings :override #'ignore)
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
  (setq evil-normal-state-modes nil)
  (setq evil-operator-state-modes nil)
  (setq evil-visual-state-modes nil)

  (evil-mode 1)
  :config
  ;; These conflict with other functions, just use the defaults
  ;; (defalias 'motion 'evil-motion-state)
  ;; (defalias 'emacs 'evil-emacs-state)
  ;; (defalias 'insert 'evil-insert-state)
  ;; (defalias 'normal 'evil-normal-state)

  ;; Enable redo
  (evil-set-undo-system 'undo-redo)

  ;; Bindings
  (defvar rk/evil-leader-map (make-keymap))
  ;; Don't enable this, it's too easy to keep hitting it in buffers that don't
  ;; support it otherwise
  (define-key rk/evil-leader-map (kbd "l") 'consult-occur)
  (define-key rk/evil-leader-map (kbd "b")
    'consult-buffer)
  (define-key rk/evil-leader-map (kbd "f")
    'rk/consult-fd)
  (define-key rk/evil-leader-map (kbd "F")
    'rk/consult-fd-pwd)
  (define-key rk/evil-leader-map (kbd "/")
    'consult-ripgrep)
  (define-key rk/evil-leader-map (kbd "i")
    'consult-imenu)
  (define-key rk/evil-leader-map (kbd "w")
    'toggle-truncate-lines)
  (define-key rk/evil-leader-map (kbd "=")
    'eglot-format-buffer)
  (define-key rk/evil-leader-map (kbd "a")
    'eglot-code-actions)
  (define-key rk/evil-leader-map (kbd "r")
    'eglot-rename)
  (define-key rk/evil-leader-map (kbd "c")
    'eglot-completion-at-point)
  (define-key rk/evil-leader-map (kbd "l")
    'consult-line)
  (define-key rk/evil-leader-map (kbd "k")
    'eldoc-doc-buffer)
  (define-key rk/evil-leader-map (kbd "d")
    'eldoc-doc-buffer)
  ;; (define-key rk/evil-leader-map (kbd "q")
  ;;   'grep-toggle-buffer)
  (define-key rk/evil-leader-map (kbd "q")
    'consult-compile-error)
  (define-key rk/evil-leader-map (kbd "`")
    'eshell)
  (define-key rk/evil-leader-map (kbd "y g")
    'kill-grep)
  (define-key rk/evil-leader-map (kbd "r")
    'consult-recent-file)

  (with-eval-after-load 'evil-maps
    (defun rk/ispell-save-word ()
      (interactive)
      (let ((current-location (point))
            (word (flyspell-get-word)))
        (when (consp word)
          (flyspell-do-correct 'save
                               nil
                               (car word)
                               current-location
                               (cadr word)
                               (caddr word)
                               current-location))
        (setq ispell-pdict-modified-p nil)))
    (define-key evil-normal-state-map "zg" 'rk/ispell-save-word)
    (define-key evil-normal-state-map "z=" 'ispell-word)
    (define-key evil-normal-state-map (kbd "C-.") nil)
    (define-key evil-normal-state-map (kbd "M-.") nil)
    (define-key evil-normal-state-map (kbd "SPC") rk/evil-leader-map)
    (define-key evil-normal-state-map (kbd "<backspace>") 'scroll-down-command)
    (define-key evil-normal-state-map (kbd "DEL") 'scroll-down-command)
    (define-key evil-normal-state-map (kbd "g r") 'xref-find-references)
    (define-key evil-normal-state-map (kbd "g k") 'find-file-at-point)
    (define-key evil-normal-state-map (kbd "g y") 'eglot-find-typeDefinition)
    (define-key evil-normal-state-map (kbd "g i") 'eglot-find-implementation)
    (define-key evil-normal-state-map (kbd "g d") 'xref-find-definitions)
    (define-key evil-normal-state-map (kbd "M-c") 'rk/consult-z-subdir)
    (define-key evil-normal-state-map (kbd "M--") 'rk/consult-z-parentdir)
    (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
    ;; Visual Line
    (define-key evil-motion-state-map
      (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
    (define-key evil-motion-state-map
      (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
    ;; Motion
    ;; Motion binds normal and visual
    (define-key evil-motion-state-map (kbd "M-.") nil)
    (define-key evil-motion-state-map (kbd "C-.") nil)
    (define-key evil-motion-state-map (kbd "C-y") nil)
    (define-key evil-motion-state-map [down-mouse-1] nil)
    (define-key evil-motion-state-map (kbd "C-w") rk/window-map)
    (define-key evil-motion-state-map (kbd "C-z") 'suspend-frame)
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "C-l") 'evil-ex-nohighlight)
    (define-key evil-motion-state-map (kbd "<backspace>") 'scroll-down-command)
    (define-key evil-motion-state-map (kbd "DEL") 'scroll-down-command)
    (define-key evil-motion-state-map (kbd "SPC") 'scroll-up-command)
    ;; `nil' breaks `C-i' to jump forward in normal mode
    ;; But without setting this to `nil' (and then setting `C-i' to
    ;; `evil-jump-forward' in normal) `TAB' doesn't work to jump to links in
    ;; help buffers
    (define-key evil-motion-state-map (kbd "TAB") nil)
    (define-key evil-motion-state-map (kbd "-") 'dired-jump)
    (define-key evil-motion-state-map (kbd "Z Q") 'evil-quit)
    (define-key evil-motion-state-map (kbd "+") nil)
    (define-key evil-motion-state-map (kbd "M-z") 'rk/consult-z)
    ;; Conflicts with Dired shell command, also not part of the standard Vim API
    (define-key evil-motion-state-map (kbd "!") nil)
    ;; Visual
    (define-key evil-visual-state-map (kbd "q") 'evil-force-normal-state)
    )

  ;; Ex Commands
  (evil-ex-define-cmd "Ei" 'edit-init)
  (evil-ex-define-cmd "Pq" 'yank-to-grep-buffer)
  (evil-ex-define-cmd "Unew" 'untitled-create-split-vertically)
  (evil-ex-define-cmd "Uvnew" 'untitled-create-split-horizontally)
  (evil-ex-define-cmd "Uenew" 'untitled-create)
  (evil-define-command rk/ex-rg (arg)
    (interactive "<a>")
    (compilation-start
     (concat
      "rg --color=always --colors 'match:fg:white' --colors 'match:bg:cyan' --smart-case --no-heading --line-number" " "
      arg)
     'grep-mode)
    )
  (evil-ex-define-cmd "Rg" 'rk/ex-rg)
  (evil-define-command rk/rename-current-buffer-file (new-filename &optional bang)
    :repeat nil
    :move-point nil
    (interactive "<f><!>")
    (let ((name (buffer-name))
          (old-filename (buffer-file-name)))
      (if (not old-filename)
          (message "Buffer '%s' is not visiting a file!" name)
        (progn
          (rename-file name new-filename bang)
          (if (get-buffer new-filename)
              (kill-buffer new-filename)
            )
          (rename-buffer new-filename)
          (set-visited-file-name new-filename)
          (set-buffer-modified-p nil)
          )
        )
      )
    )

  (evil-define-command rk/remove-current-buffer-file ()
    "Kill the current buffer and deletes the file it is visiting."
    (interactive)
    (let ((filename (buffer-file-name)))
      (when filename
        (if (vc-backend filename)
            (vc-delete-file filename)
          (progn
            (delete-file filename)
            (message "Deleted file %s" filename)
            (kill-buffer))))))

  (evil-ex-define-cmd "Remove" 'rk/remove-current-buffer-file)
  (evil-ex-define-cmd "Rename" 'rk/rename-current-buffer-file)

  ;; Allow crossing lines by moving past end of line
  (setq-default evil-cross-lines t)

  ;; Prevent evil from forcing `set-mark-command' from entering visual mode
  ;; (which has weird side effects like breaking `forward-sexp')
  ;; (add-hook 'evil-local-mode-hook
  ;;           (lambda ()
  ;;             (remove-hook 'activate-mark-hook
  ;;                          'evil-visual-activate-hook t)))

  ;; Modes

  ;; Normal
  (evil-set-initial-state 'prog-mode 'normal)
  (evil-set-initial-state 'text-mode 'normal)
  (evil-set-initial-state 'conf-mode 'normal)
  ;; Git Commit
  (evil-set-initial-state 'with-editor-mode 'insert)

  ;; Special mode that triggers for long lines
  (evil-set-initial-state 'so-long-mode 'normal)
  ;; `*eldoc*' buffer is also `fundamental', need to target this more
  ;; specifically.
  ;; (evil-set-initial-state 'fundamental-mode 'normal)
  (if (eq evil-default-state 'motion)
      (progn
        ;; Insert
        (evil-set-initial-state 'eshell-mode 'insert)
        ;; Ediff
        (evil-set-initial-state 'ediff-mode 'emacs)
        )
    )

  (with-eval-after-load 'dired
    (evil-define-key 'motion dired-mode-map (kbd "SPC") rk/evil-leader-map)
    (evil-define-key 'emacs dired-mode-map (kbd "-") 'dired-up-directory)
    )

  (with-eval-after-load 'esh-mode
    (evil-define-key 'normal eshell-mode-map (kbd "M-z") 'rk/consult-eshell-z)
    (evil-define-key 'insert eshell-mode-map (kbd "M-z") 'rk/consult-eshell-z)
    )

  ;; Troubleshooting

  ;; `wgrep'
  (defadvice wgrep-change-to-wgrep-mode (after rk/wgrep-change-to-wgrep-mode)
    (if (evil-motion-state-p)
        (evil-normal-state)
      )
    )
  (defadvice wgrep-to-original-mode (after rk/wgrep-to-original-mode)
    (if (or (evil-normal-state-p) (evil-insert-state-p)
            (evil-motion-state)
            )
        )
    )

  ;; `wdired'
  (defadvice wdired-change-to-dired-mode (after rk/wdired-change-to-dired-mode)
    (if (or (evil-normal-state-p) (evil-insert-state-p)
            (evil-motion-state)
            )
        )
    )
  (add-hook 'wdired-mode-hook
            (lambda ()
              (if (evil-motion-state-p)
                  (evil-normal-state)
                )
              )
            )

  ;; `org-agenda'
  ;; Fix a bug where `org-agenda-redo-all' from `\g' leaves agenda in Emacs
  ;; state
  (defadvice org-agenda-redo-all (before rk/org-agenda-redo-all-cleanup)
    (if (evil-emacs-state-p)
        (evil-motion-state)
      )
    )

  ;; Packages

  (use-package evil-visualstar
    :init
    (global-evil-visualstar-mode)
    ;; This causes `*' than `n' to extend the selection, which clearly isn't
    ;; desirable. Not sure why this was ever enabled to begin with
    ;; (setq evil-visualstar/persistent t)
    )

  (use-package evil-surround
    :init
    (global-evil-surround-mode 1)
    )

  (use-package evil-commentary
    :diminish
    ;; Disable binding that conflicts with `eglot-find-typeDefinition'
    :init
    (evil-commentary-mode)
    :config
    (evil-define-key 'normal evil-commentary-mode-map (kbd "gy") nil)
    )

  (use-package evil-goggles
    :diminish
    :config
    (setq evil-goggles-enable-delete nil)
    (setq evil-goggles-enable-change nil)
    (setq evil-goggles-enable-indent nil)
    (setq evil-goggles-enable-yank t)
    (setq evil-goggles-enable-join nil)
    (setq evil-goggles-enable-fill-and-move nil)
    (setq evil-goggles-enable-paste nil)
    (setq evil-goggles-enable-shift nil)
    (setq evil-goggles-enable-surround nil)
    (setq evil-goggles-enable-commentary nil)
    (setq evil-goggles-enable-nerd-commenter nil)
    (setq evil-goggles-enable-replace-with-register nil)
    (setq evil-goggles-enable-set-marker nil)
    (setq evil-goggles-enable-undo nil)
    (setq evil-goggles-enable-redo nil)
    (setq evil-goggles-enable-record-macro nil)
    (evil-goggles-mode)
    (setq evil-goggles-duration 0.200)
    (setq evil-goggles-pulse nil)
    )

  (use-package evil-numbers
    :bind (
           (:map evil-normal-state-map
                 ("C-a" . evil-numbers/inc-at-pt)
                 ("C-S-a". evil-numbers/dec-at-pt)
                 )
           (:map rk/evil-leader-map
                 ("C-x" . evil-numbers/dec-at-pt))
           )
    :commands (evil-numbers/inc-at-pt evil-numbers/dec-at-pt)
    )

  ;; This doesn't work that well, requires a second key to be pressed before the
  ;; cursor changes
  ;; (use-package evil-terminal-cursor-changer
  ;;   :config
  ;;   (unless (display-graphic-p)
  ;;     ;; Prevent blinking cursor from getting stuck when exiting emacs
  ;;     (blink-cursor-mode 0)
  ;;     (evil-terminal-cursor-changer-activate)
  ;;     (setq evil-motion-state-cursor 'box)
  ;;     (setq evil-visual-state-cursor 'box)
  ;;     (setq evil-normal-state-cursor 'box)
  ;;     (setq evil-insert-state-cursor 'bar)
  ;;     (setq evil-emacs-state-cursor  'hbar)
  ;;     )
  ;;   )
  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here
