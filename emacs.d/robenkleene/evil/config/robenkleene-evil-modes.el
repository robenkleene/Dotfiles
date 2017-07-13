;;; robenkleene-evil-modes.el --- robenkleene-evil-modes
;;; Commentary:
;;; Code:

(require 'robenkleene-evil-integration)

;; Basic
(defvar evil-motion-state-modes)
(defvar evil-emacs-state-modes)
(defvar evil-insert-state-modes)
(setq evil-motion-state-modes nil)
(setq evil-emacs-state-modes '(magit-popup-mode))
(setq evil-insert-state-modes nil)

(robenkleene/evilify 'debug 'debugger-mode debugger-mode-map 'motion)
(robenkleene/evilify 'help 'help-mode help-mode-map 'motion)
(robenkleene/evilify 'help 'help-mode help-mode-map 'motion)
(robenkleene/evilify 'dired 'dired-mode dired-mode-map 'motion)
(robenkleene/evilify 'magit 'magit-status-mode magit-status-mode-map 'motion
                     "C-k" 'magit-discard
                     )

(provide 'robenkleene-evil-modes)
;;; robenkleene-evil-modes.el ends here
