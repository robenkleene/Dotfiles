;;; robenkleene-bindings.el --- robenkleene-bindings
;;; Commentary:
;;; Code:

;; Jump to source for function
(global-set-key (kbd "C-c i") 'robenkleene/edit-init)
(global-set-key (kbd "C-c w") 'toggle-truncate-lines)
;; This should eventually go to `counsel-imenu' but it's not in the version of
;; `swiper' I have yet
(global-set-key (kbd "C-c s") 'imenu)
(global-set-key (kbd "C-c t") 'robenkleene/open-terminal-window)
(global-set-key (kbd "C-c r") 'robenkleene/reveal-in-finder)
(global-set-key (kbd "C-c d") 'robenkleene/emacs-documentation)
(global-set-key (kbd "C-c o") 'other-frame)
(global-set-key (kbd "C-c 0") 'delete-frame)
(global-set-key (kbd "C-c 2") 'make-frame-command)

(provide 'robenkleene-bindings)
;;; robenkleene-bindings.el ends here
