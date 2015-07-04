;;; robenkleene-dired.el --- robenkleene-dired
;;; Commentary:
;;; Code:

;; Using Evilify with Dired, this shouldn't be necessary anymore
(eval-after-load 'dired
   '(progn
      ;; Search behaves more prodiecably with symlinks visiable
      (setq dired-hide-details-hide-symlink-targets nil)
      (defvar dired-mode-map)
      (define-key dired-mode-map (kbd "-") 'dired-up-directory)

      ;; Using Evilify these bindings aren't necessary
      ;; (define-key dired-mode-map (kbd "?") 'evil-search-backward)
      ;; (define-key dired-mode-map (kbd "n")'evil-search-next)
      ;; (define-key dired-mode-map (kbd "g") 'revert-buffer)
      ;; (define-key dired-mode-map "N" 'evil-search-previous)
     ))

;; Suppress error message
(defvar dired-use-ls-dired)
(setq dired-use-ls-dired nil)

;; Hide details (show them with "\("
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(provide 'robenkleene-dired)
;;; robenkleene-dired.el ends here
