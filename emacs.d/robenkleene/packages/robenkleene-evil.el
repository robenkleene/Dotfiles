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
   evil-insert-state-tag
   (propertize " I " 'face '((:background "royalblue" :foreground "white")))
   evil-emacs-state-tag
   (propertize " E " 'face '((:background "slateblue" :foreground "white")))
   evil-motion-state-tag
   (propertize " M " 'face '((:background "violet" :foreground "white")))
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

  ;; Start out in emacs mode
  ;; (setq evil-default-state 'insert)

  ;; Don't let anything override Evil
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
  ;; Starting modes without Evil enabled
  (evil-set-initial-state 'dired-mode 'emacs)
  ;; This starts commit editing in insert mode
  ;; (add-hook 'with-editor-mode-hook 'evil-insert-state)

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
    (define-key evil-motion-state-map (kbd "g f") 'find-file-at-point)

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
  (setq-default evil-cross-lines t)

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
    (global-evil-surround-mode 1)
    )

  (use-package evil-commentary
    :init
    (evil-commentary-mode)
    )

  )

(provide 'robenkleene-evil)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-evil.el ends here
