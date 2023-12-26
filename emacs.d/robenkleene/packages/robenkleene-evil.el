;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

;; Just use default Emacs in insert mode
;; This won't work in `:config'
(setq evil-disable-insert-state-bindings t)

(use-package evil
  :commands (evil-mode)
  :init
  (evil-mode 1)
  :config
  ;; Prevent cutting when doing a visual paste, which breaks visual paste
  ;; completely when system clipboard integration is present because the yank
  ;; overwrites what's intended to paste
  (setq-default evil-kill-on-visual-paste nil)

  ;; Don't show last ex command or search by default
  (setq-default evil-want-empty-ex-last-command nil)

  ;; Persist search highlighting
  (setq evil-search-module 'evil-search)

  ;; Make `Y' yank to eol
  (setq evil-want-Y-yank-to-eol t)

  ;; Use right and below as default split
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)

  ;; Allow crossing lines by moving past end of line
  (setq-default evil-cross-lines t)

  ;; Enable redo
  (evil-set-undo-system 'undo-redo)

  ;; Disabling all Evil "smart" features
  ;; subvert evil-operation.el overrides (dired, ibuffer etc.)
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

  (with-eval-after-load 'evil
    ;; Use symbols instead of words, so evil treats `-' and `_' as part of a word
    ;; Disabling this because it causes move by word to jump over paths, e.g.,
    ;; `/this/is/a/path'
    ;; (defalias #'forward-evil-word #'forward-evil-symbol)
    (setq-default evil-symbol-word-search t))

  ;; Modes
  (setq evil-default-state 'emacs)
  (evil-set-initial-state 'prog-mode 'insert)
  (evil-set-initial-state 'text-mode 'insert)
  (evil-set-initial-state 'conf-mode 'insert)

  ;; Bindings
  (defvar rk/evil-leader-map (make-keymap))
  (define-key rk/evil-leader-map (kbd "l") 'consult-occur)
  (define-key rk/evil-leader-map (kbd "b")
              'consult-buffer)
  (define-key rk/evil-leader-map (kbd "f")
              'rk/consult-fd)
  (define-key rk/evil-leader-map (kbd "g")
              'consult-ripgrep)
  (define-key rk/evil-leader-map (kbd "i")
              'consult-imenu)
  (define-key rk/evil-leader-map (kbd "r")
              'consult-recent-file)
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
    (define-key evil-insert-state-map "C-w" nil)
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
    (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
    ;; Visual Line
    (define-key evil-motion-state-map
                (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
    (define-key evil-motion-state-map
                (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
    )

  ;; Ex Commands
  (evil-define-command rk/ex-rg (arg)
    (interactive "<a>")
    (compilation-start
     (concat
      "rg --color=always --colors 'match:fg:white' --colors 'match:bg:cyan' --smart-case --no-heading --line-number" " "
      arg)
     'grep-mode)
    )
  (evil-ex-define-cmd "Rg" 'rk/ex-rg)

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

  (use-package evil-numbers
    :commands evil-mode
    :bind (
           (:map evil-normal-state-map
                 ("C-a" . evil-numbers/inc-at-pt)
                 ("C-x". evil-numbers/dec-at-pt)
                 )
           )
    )
  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here
