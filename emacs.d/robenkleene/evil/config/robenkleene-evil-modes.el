;;; robenkleene-evil-modes.el --- robenkleene-evil-modes
;;; Commentary:
;;; Code:

(require 'robenkleene-evil-integration)

;; Basic
(defvar evil-motion-state-modes)
(defvar evil-emacs-state-modes)
(defvar evil-insert-state-modes)
(setq evil-motion-state-modes '(magit-revision-mode))
(setq evil-emacs-state-modes '(magit-popup-mode))
(setq evil-insert-state-modes '(eshell-mode))
;; Don't do this because it is disorientating when just editing a snippet
;; (setq evil-insert-state-modes '(snippet-mode))

;; Debug
(robenkleene/evilify 'debug 'debugger-mode debugger-mode-map 'motion)
(add-to-list 'evil-motion-state-modes 'debugger-mode)

;; help
(defvar robenkleene/help-unimpaired-next-map (make-keymap))
(defvar robenkleene/help-unimpaired-previous-map (make-keymap))
(define-key robenkleene/help-unimpaired-next-map (kbd "]") 'forward-button)
(define-key robenkleene/help-unimpaired-previous-map (kbd "[") 'backward-button)
(robenkleene/evilify 'help 'help-mode help-mode-map 'motion
                     "[" robenkleene/help-unimpaired-previous-map
                     "]" robenkleene/help-unimpaired-next-map
                     "\C-o" 'help-go-back
                     "\C-i" 'help-go-forward
                     "\C-i" 'help-go-forward
                     )
(add-to-list 'evil-motion-state-modes 'help-mode)

;; help
(robenkleene/evilify 'man 'Man-mode Man-mode-map 'motion)
(add-to-list 'evil-motion-state-modes 'Man-mode)

;; dired
(robenkleene/evilify 'dired 'dired-mode dired-mode-map 'motion)
(add-to-list 'evil-motion-state-modes 'dired-mode)

;; grep
(robenkleene/evilify 'grep 'grep-mode grep-mode-map 'motion)
(add-to-list 'evil-motion-state-modes 'grep-mode)
(defadvice wgrep-change-to-wgrep-mode
    (after robenkleene/wgrep-to-motion-state () activate)
  "Switch to normal mode when entering `wgrep' and widen."
  (let ((start (wgrep-goto-first-found))
        (end (wgrep-goto-end-of-found)))
    (narrow-to-region start end))
  (evil-normal-state)
  )
(defadvice wgrep-to-original-mode
    (after robenkleene/wgrep-to-normal-state () activate)
  "Switch to normal mode when entering `wgrep'.
Also narrow to just the results so find and replace doesn't try to
edit the read-only parts."
  (widen)
  (evil-motion-state)
  )

;; magit
;; This doesn't work because `evil-define-key` doesn't work with `magit-file-section-map'
;; (robenkleene/evilify 'magit 'magit-status-mode magit-file-section-map 'motion
;;                      "C-k" 'magit-discard
;;                      )
;; Start commits in insert mode
(add-hook 'with-editor-mode-hook 'evil-insert-state)
(defvar robenkleene/magit-unimpaired-next-map (make-keymap))
(defvar robenkleene/magit-unimpaired-previous-map (make-keymap))
(define-key robenkleene/magit-unimpaired-next-map (kbd "]") 'magit-section-forward-sibling)
(define-key robenkleene/magit-unimpaired-previous-map (kbd "[") 'magit-section-backward-sibling)
(robenkleene/evilify 'magit 'magit-status-mode magit-status-mode-map 'motion
                     "[" robenkleene/magit-unimpaired-previous-map
                     "]" robenkleene/magit-unimpaired-next-map
                     "TAB" 'magit-toggle-section
                     )
(with-eval-after-load 'magit
  (defvar magit-file-section-map)
  (define-key magit-file-section-map "\C-k" 'magit-discard)
  (defvar magit-hunk-section-map)
  (define-key magit-hunk-section-map "\C-k" 'magit-discard)
  (define-key magit-hunk-section-map "a" nil)
  )
(add-to-list 'evil-motion-state-modes 'magit-status-mode)

(provide 'robenkleene-evil-modes)
;;; robenkleene-evil-modes.el ends here
