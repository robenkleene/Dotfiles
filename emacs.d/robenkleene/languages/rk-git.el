;; magit
(rk-install-package-if-missing 'magit)
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "#95E452")
     (set-face-foreground 'magit-diff-del "#E5796A")
     (set-face-background 'magit-item-highlight "#222222")
     (setq magit-status-buffer-switch-function 'switch-to-buffer)
     ))

;; Magit Startup Helpers
(defun rk-magit-status-current-window () 
  "Magit in current window."
  (interactive)
  (progn (call-interactively 'magit-status) 
	 (delete-other-windows)))
(defun rk-focus-selected-frame ()
  "Focus on current frame."
  (select-frame-set-input-focus (selected-frame)))
(defun rk-magit-status-startup ()
  "Startup magit full frame with focus."
  (progn (rk-magit-status-current-window) (rk-focus-selected-frame)))

;; ediff
(eval-after-load 'ediff
  '(progn
     (setq ediff-window-setup-function 'ediff-setup-windows-plain)
     ))


(provide 'rk-git)
