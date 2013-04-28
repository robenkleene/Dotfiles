(provide 'rk-features)

;; recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; Fuzzy matching
;; icomplete-mode
;; ido-mode style completion in describe-varable, etc...
(icomplete-mode t)
;; Key Bindings
(global-set-key (kbd "s-b") 'ido-switch-buffer)
;; With recentf
(global-set-key (kbd "s-r") 'rk-recentf-ido-find-file)
(defun rk-recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
