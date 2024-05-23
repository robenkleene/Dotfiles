;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(use-package evil
  :commands (evil-mode)
  :init
  ;; Just use default Emacs in insert mode
  (setq evil-disable-insert-state-bindings t)
  ;; Configure all this before starting evil for existing buffers
  ;; Disabling all the "smart" Evil features
  (setq evil-overriding-maps nil
        evil-intercept-maps nil
        evil-pending-intercept-maps nil
        evil-pending-overriding-maps nil)
  (advice-add 'evil-make-overriding-map :override #'ignore)
  (advice-add 'evil-make-intercept-map :override #'ignore)
  (advice-add 'evil-add-hjkl-bindings :override #'ignore)
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
  (setq evil-normal-state-modes nil)
  (setq evil-operator-state-modes nil)
  (setq evil-visual-state-modes nil)
  ;; Modes
  (setq evil-default-state 'emacs)
  ;; Start Evil
  (evil-mode 1)
  :config
  ;; Set initial state for some modes
  (evil-set-initial-state 'text-mode 'normal)
  (evil-set-initial-state 'conf-mode 'normal)
  (evil-set-initial-state 'prog-mode 'normal)
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  ;; Lisp in insert mode
  ;; (evil-set-initial-state 'prog-mode 'normal)
  ;; (evil-set-initial-state 'lisp-mode 'insert)
  ;; (evil-set-initial-state 'emacs-lisp-mode 'insert)
  ;; (evil-set-initial-state 'lisp-interaction-mode 'insert)
  ;; Git Commit
  (add-hook 'with-editor-mode-hook 'evil-insert-state)

  ;; Prevent cutting when doing a visual paste, which breaks visual paste
  ;; completely when system clipboard integration is present because the yank
  ;; overwrites what's intended to paste
  (setq-default evil-kill-on-visual-paste nil)

  ;; Make `Y' yank to eol
  (setq evil-want-Y-yank-to-eol t)

  ;; Use right and below as default split
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)

  ;; Enable redo
  (evil-set-undo-system 'undo-redo)

  ;; After Load
  (with-eval-after-load 'evil
    ;; Use symbols instead of words, so evil treats `-' and `_' as part of a word
    ;; Disabling this because it causes move by word to jump over paths, e.g.,
    ;; `/this/is/a/path'
    ;; (defalias #'forward-evil-word #'forward-evil-symbol)
    (setq-default evil-symbol-word-search t))

  (with-eval-after-load 'evil-maps
    ;; Allow `xref-find-definitions' in normal mode
    (define-key evil-normal-state-map (kbd "M-.") nil)
    (define-key evil-motion-state-map (kbd "C-z") nil)
    (define-key evil-insert-state-map (kbd "C-z") nil)
    (define-key evil-emacs-state-map (kbd "C-z") nil)
    ;; Visual Line
    (define-key evil-motion-state-map
                (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
    (define-key evil-motion-state-map
                (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
    )

  ;; Packages

  (use-package evil-visualstar
    :config
    (global-evil-visualstar-mode)
    )

  (use-package evil-surround
    :config
    (global-evil-surround-mode 1)
    )

  (use-package evil-commentary
    :diminish
    :config
    (evil-commentary-mode)
    (evil-define-key 'normal evil-commentary-mode-map (kbd "gy") nil)
    )
  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here

