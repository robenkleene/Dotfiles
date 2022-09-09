;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package evil
  :commands (evil-mode)
  :bind
  (:map robenkleene/leader-map
        ("[" . evil-mode)
        ("j" . evil-mode)
        ("/" . (lambda ()
                 (interactive)
                 (evil-mode)
                 (evil-search-forward)))
        ("?" . (lambda ()
                 (interactive)
                 (evil-mode)
                 (evil-search-backward)))
        )
  :init
  ;; (setq evil-toggle-key "")
  ;; hl-line in normal mode & cursor fix
  (add-hook 'evil-mode-hook
            (lambda ()
              (unless evil-mode
                (if (display-graphic-p)
                    (robenkleene/evil-fix-cursor)
                  )
                )
              (if evil-mode
                  (progn
                    (if (eq evil-state 'normal)
                        (progn
                          (hl-line-mode +1)
                          (blink-cursor-mode -1)
                          )
                      (blink-cursor-mode)
                      )
                    )
                (blink-cursor-mode)
                )
              )
            )
  (add-hook 'evil-normal-state-entry-hook (lambda () (hl-line-mode +1)))
  (add-hook 'evil-normal-state-exit-hook (lambda () (hl-line-mode -1)))

  ;; Save when exiting insert mode
  (add-hook 'evil-insert-state-exit-hook
            'robenkleene/save-buffer-if-visiting-file)

  ;; Use symbols instead of words, so evil treats `-' and `_' as part of a word
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

  ;; Prevent cutting when doing a visual paste, which breaks visual paste
  ;; completely when system clipboard integration is present because the yank
  ;; overwrites what's intended to paste
  (setq-default evil-kill-on-visual-paste nil)

  ;; Don't show last ex command or search by default
  (setq-default evil-want-empty-ex-last-command nil)
  
  (defun robenkleene/evil-fix-cursor ()
    (interactive)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (kill-local-variable 'cursor-type))))
  (setq evil-disable-insert-state-bindings t)
  ;; Persist search highlighting
  (setq evil-search-module 'evil-search)
  ;; (setq evil-default-state 'insert)
  ;; (add-hook 'text-mode-hook 'evil-mode)
  ;; (add-hook 'prog-mode-hook 'evil-mode)

  ;; Don't let anything override Evil
  ;; don't let modes override any states (!)
  (setq evil-overriding-maps nil
        evil-intercept-maps nil
        evil-pending-intercept-maps nil
        evil-pending-overriding-maps nil)
  ;; subvert evil-operation.el overrides (dired, ibuffer etc.)
  (advice-add 'evil-make-overriding-map :override #'ignore)
  (advice-add 'evil-make-intercept-map  :override #'ignore)
  (advice-add 'evil-add-hjkl-bindings   :override #'ignore)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)

  (evil-mode 1)
  :config
  ;; (unless (display-graphic-p)
  ;;   (use-package evil-terminal-cursor-changer
  ;;     :config
  ;;     (evil-terminal-cursor-changer-activate)
  ;;     (setq evil-motion-state-cursor 'box)
  ;;     (setq evil-visual-state-cursor 'box)
  ;;     (setq evil-normal-state-cursor 'box)
  ;;     (setq evil-insert-state-cursor 'bar)
  ;;     (setq evil-emacs-state-cursor  'hbar)
  ;;     )
  ;;   )
  (evil-set-undo-system 'undo-redo)

  ;; Bindings
  (defvar robenkleene/evil-leader-map (make-keymap))
  (define-key robenkleene/evil-leader-map (kbd "o i") 'robenkleene/edit-init)
  (define-key robenkleene/evil-leader-map (kbd "l") 'helm-occur)
  (define-key robenkleene/evil-leader-map (kbd "h") 'helm-resume)
  (with-eval-after-load 'evil-maps
    ;; Normal
    (define-key evil-normal-state-map (kbd "C-w t")
      (lambda () (interactive) (make-frame) (other-frame 1)))
    (define-key evil-normal-state-map (kbd "C-w C-t")
      (lambda () (interactive) (make-frame) (other-frame 1)))
    (define-key evil-normal-state-map (kbd "C-w p")
      (lambda () (interactive) (other-frame -1)))
    (define-key evil-normal-state-map (kbd "C-w n")
      'other-frame)
    (define-key evil-normal-state-map (kbd "C-w C-p")
      (lambda () (interactive) (other-frame -1)))
    (define-key evil-normal-state-map (kbd "C-w C-n")
      'other-frame)
    (define-key evil-normal-state-map (kbd "M-a") robenkleene/leader-map)
    (define-key evil-normal-state-map (kbd "-") 'dired-jump)
    ;; (define-key evil-normal-state-map (kbd "<escape>") 'evil-insert)
    (define-key evil-normal-state-map (kbd "M-.") nil)
    (define-key evil-normal-state-map (kbd "C-.") nil)
    (defun robenkleene/ispell-save-word ()
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
    (define-key evil-normal-state-map "zg" 'robenkleene/ispell-save-word)
    (define-key evil-normal-state-map "z=" 'ispell-word)
    (define-key evil-motion-state-map (kbd "C-y") nil)
    (define-key evil-motion-state-map [down-mouse-1] nil)
    (define-key evil-normal-state-map (kbd "SPC") robenkleene/evil-leader-map)
    ;; Motion
    (define-key evil-motion-state-map (kbd "C-z") 'suspend-frame)
    ;; Motion binds normal and visual
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "C-l") 'evil-ex-nohighlight)
    (define-key evil-motion-state-map (kbd "TAB") nil)
    (define-key evil-motion-state-map (kbd "SPC") robenkleene/evil-leader-map)
    ;; You can't `p' to paste if you're in `set-mark-command' so just always go
    ;; to insert mode in order to use `C-y' for paste. It's too confusing
    ;; otherwise.
    (define-key evil-motion-state-map (kbd "C-@")
      (lambda ()
        (interactive)
        (call-interactively 'evil-insert)
        (call-interactively 'set-mark-command)))
    (define-key evil-motion-state-map (kbd "C-SPC")
      (lambda ()
        (interactive)
        (call-interactively 'evil-insert)
        (call-interactively 'set-mark-command)))
    ;; (define-key evil-normal-state-map (kbd "q") 'evil-mode)
    ;; Visual Line Movement
    ;; (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    ;; (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
    ;; (define-key evil-motion-state-map (kbd "<DOWN>") 'evil-next-visual-line)
    ;; (define-key evil-motion-state-map (kbd "<UP>") 'evil-previous-visual-line)
    (define-key evil-normal-state-map
      (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
    (define-key evil-normal-state-map
      (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
    (define-key evil-motion-state-map
      (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
    (define-key evil-motion-state-map
      (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line))
  (define-key evil-visual-state-map (kbd "q") 'evil-force-normal-state)
  ;; Evil
  ;; Evil Goggles is broken for this
  ;; (evil-define-key 'normal global-map (kbd "Y") (kbd "y$"))
  (evil-define-key 'normal global-map
    (kbd "Y")
    (lambda () (interactive)
      (evil-goggles--show-blocking-hint (point) (line-end-position))
      (evil-yank (point) (line-end-position))))

  ;; Along crossing lines by moving past end of line
  (setq-default evil-cross-lines t)

  ;; Modes
  (evil-define-key 'normal dired-mode-map
    (kbd "R") 'dired-do-rename)
  (evil-define-key 'normal dired-mode-map
    (kbd "C") 'dired-do-copy)
  (evil-define-key 'normal dired-mode-map
    (kbd "+") 'dired-create-directory)
  ;; Languages
  (evil-define-key 'normal emacs-lisp-mode-map
    (kbd "K") 'robenkleene/describe-thing-at-point)
  (evil-define-key 'normal lisp-interaction-mode-map
    (kbd "K") 'robenkleene/describe-thing-at-point)

  ;; Prevent evil from forcing `set-mark-command' from entering visual mode
  ;; (which has weird side effects like breaking `forward-sexp')
  (add-hook 'evil-local-mode-hook
            (lambda ()
              (remove-hook 'activate-mark-hook
                           'evil-visual-activate-hook t)))
  ;; Allow evil to go one character beyond the last which makes it easier to
  ;; capture sexp
  ;; (I forgot why I turned this on, but I suspect it's something that's already
  ;; solved by going into insert mode automatically on `set-mark-command')
  ;; (setq evil-move-beyond-eol t)

  ;; Packages
  (use-package evil-visualstar
    :commands (evil-visualstar/begin-search-forward
               evil-visualstar/begin-search-backward)
    :init
    (progn
      (define-key evil-visual-state-map (kbd "*")
        'evil-visualstar/begin-search-forward)
      (define-key evil-visual-state-map (kbd "#")
        'evil-visualstar/begin-search-backward)))
  (use-package evil-surround
    :init
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
    (global-evil-surround-mode 1)
    )

  (use-package evil-goggles
    :ensure t
    :config
    (evil-goggles-mode)
    (setq evil-goggles-duration 0.300)
    (setq evil-goggles-pulse nil)
    )
  (use-package evil-commentary
    :init
    (evil-commentary-mode)
    )
  (use-package evil-numbers
    :init
    (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
    (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
    :commands (evil-numbers/inc-at-pt evil-numbers/dec-at-pt)
    )

  ;; `evil-smartparens' is incompatible with `evil-goggles'
  ;; (use-package evil-smartparens
  ;;   :init
  ;;   (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
  ;;   )
  ;; This messes too much with regular vim bindings
  ;; (use-package evil-cleverparens
  ;;   :config
  ;;   (setq evil-cp-regular-bindings)
  ;;   :init
  ;;   (add-hook 'smartparens-enabled-hook #'evil-cleverparens-mode)
  ;;   )

  (use-package crux
    :commands (crux-delete-file-and-buffer)
    :init
    (evil-ex-define-cmd "Remove" 'crux-delete-file-and-buffer)
    (evil-ex-define-cmd "Rename" 'crux-rename-file-and-buffer)
    (evil-ex-define-cmd "Archive" 'robenkleene/archive-current-file)
    )
  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here
