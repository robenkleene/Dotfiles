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
(setq evil-insert-state-modes nil)

;; Debug
(robenkleene/evilify 'debug 'debugger-mode debugger-mode-map 'motion)
(add-to-list 'evil-motion-state-modes 'debugger-mode)

;; help
(robenkleene/evilify 'help 'help-mode help-mode-map 'motion)
(add-to-list 'evil-motion-state-modes 'help-mode)

;; dired
(robenkleene/evilify 'dired 'dired-mode dired-mode-map 'motion)
(add-to-list 'evil-motion-state-modes 'dired-mode)

;; magit
(robenkleene/evilify 'magit 'magit-status-mode magit-file-section-map 'motion
                     "C-k" 'magit-discard
                     )
(add-to-list 'evil-motion-state-modes 'magit-status-mode)

(provide 'robenkleene-evil-modes)
;;; robenkleene-evil-modes.el ends here
