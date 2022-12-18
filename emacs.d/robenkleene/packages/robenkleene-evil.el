;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package evil
  :commands (evil-mode)
  :init
  (setq
   evil-normal-state-tag
   (propertize " N " 'face '((:background "darkorchid" :foreground "white")))
   evil-operator-state-tag
   (propertize " O " 'face '((:background "darkorchid" :foreground "white")))
   evil-insert-state-tag
   (propertize " I " 'face '((:background "royalblue" :foreground "white")))
   evil-emacs-state-tag
   (propertize " E " 'face '((:background "slateblue" :foreground "white")))
   evil-motion-state-tag
   (propertize " M " 'face '((:background "violet" :foreground "white")))
   evil-visual-block-tag
   (propertize " VB " 'face '((:background "slategray" :foreground "white")))
   evil-visual-char-tag
   (propertize " VC " 'face '((:background "slategray" :foreground "white")))
   evil-visual-line-tag
   (propertize " VL " 'face '((:background "slategray" :foreground "white")))
   evil-visual-screen-line-tag
   (propertize " VSL " 'face '((:background "slategray" :foreground "white")))
   evil-visual-state-tag
   (propertize " V " 'face '((:background "slategray" :foreground "white")))
   evil-replace-state-tag
   (propertize " R " 'face '((:background "slategray" :foreground "white")))
   )

  ;; Use symbols instead of words, so evil treats `-' and `_' as part of a word
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
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

  ;; Set initial state to insert
  ;; (setq evil-default-state 'insert)

  ;; Don't let anything override Evil
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

  (evil-mode 1)
  :config
  ;; Starting modes without Evil enabled
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'eshell-mode 'insert)
  ;; This starts commit editing in insert mode
  ;; (add-hook 'with-editor-mode-hook 'evil-insert-state)

  ;; Enable redo
  (evil-set-undo-system 'undo-redo)

  ;; Bindings
  (defvar robenkleene/evil-leader-map (make-keymap))

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
    (define-key evil-normal-state-map (kbd "-") 'dired-jump)
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
    ;; Motion
    (define-key evil-motion-state-map (kbd "C-z") 'suspend-frame)
    ;; Motion binds normal and visual
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "C-l") 'evil-ex-nohighlight)
    (define-key evil-motion-state-map (kbd "TAB") nil)
    (define-key evil-motion-state-map (kbd "SPC") robenkleene/evil-leader-map)
    (define-key evil-motion-state-map (kbd "Z Q") 'evil-quit)
    (define-key evil-motion-state-map (kbd "g f") 'xref-find-references)
    (define-key evil-motion-state-map (kbd "g r") 'find-file-at-point)
    (define-key evil-motion-state-map (kbd "g y") 'eglot-find-typeDefinition)
    (define-key evil-motion-state-map (kbd "g i") 'eglot-find-implementation)
    (define-key evil-motion-state-map (kbd "g d") 'xref-find-definitions)

    (define-key evil-normal-state-map
      (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
    (define-key evil-normal-state-map
      (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
    (define-key evil-motion-state-map
      (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
    (define-key evil-motion-state-map
      (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
    )

  (define-key evil-visual-state-map (kbd "q") 'evil-force-normal-state)

  ;; Allow crossing lines by moving past end of line
  ;; (setq-default evil-cross-lines t)

  ;; Prevent evil from forcing `set-mark-command' from entering visual mode
  ;; (which has weird side effects like breaking `forward-sexp')
  (add-hook 'evil-local-mode-hook
            (lambda ()
              (remove-hook 'activate-mark-hook
                           'evil-visual-activate-hook t)))

  ;; Modes
  (with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "j") 'next-line)
    (define-key dired-mode-map (kbd "k") 'previous-line)
    (define-key dired-mode-map (kbd "-") 'dired-jump)
    (define-key dired-mode-map (kbd "/") 'evil-ex-search-forward)
    (define-key dired-mode-map (kbd "?") 'evil-ex-search-backward)
    (define-key dired-mode-map (kbd "Z") nil)
    (define-key dired-mode-map (kbd "Z Q") 'evil-quit)
    )

  ;; Packages
  (use-package evil-visualstar
    :init
    (global-evil-visualstar-mode)
    (setq evil-visualstar/persistent t)
    :config
    (global-evil-visualstar-mode)
    )

  (use-package evil-surround
    :init
    (global-evil-surround-mode 1)
    )

  (use-package evil-commentary
    :init
    (evil-commentary-mode)
    )

  (use-package evil-goggles
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
    (setq evil-goggles-duration 0.100)
    (setq evil-goggles-pulse nil)
    )

  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here
