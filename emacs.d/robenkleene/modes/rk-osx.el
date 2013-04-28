(provide 'rk-osx)

(defvar rk-osx-minor-mode-map (make-keymap) "rk-osx-minor-mode map keymap.")

(define-key rk-osx-minor-mode-map (kbd "s-<left>") 'beginning-of-visual-line)
(define-key rk-osx-minor-mode-map (kbd "s-<right>") 'move-end-of-line)
(define-key rk-osx-minor-mode-map (kbd "s-<up>") 'beginning-of-buffer)
(define-key rk-osx-minor-mode-map (kbd "s-<down>") 'end-of-buffer)

(define-key rk-osx-minor-mode-map (kbd "M-<left>") 'left-word)
(define-key rk-osx-minor-mode-map (kbd "M-<right>") 'right-word)

(define-key rk-osx-minor-mode-map (kbd "M-S-<left>") nil)
(define-key rk-osx-minor-mode-map (kbd "M-S-<right>") nil)


(define-minor-mode rk-osx-minor-mode
  "Behave like OS X."
  :global t
  :lighter " OS-X")

(rk-osx-minor-mode 1)
