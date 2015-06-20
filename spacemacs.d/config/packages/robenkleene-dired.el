;; Dired
(require 'dired)
;; TODO: Figure out how to hide all columns except filename
;; (eval-after-load 'magit
;;    '(progn
;;       (set-face-background 'magit-item-highlight robenkleene/highlight-background-color)
;;       (define-key magit-status-mode-map (kbd "C-b") 'evil-scroll-page-up)
;;       (define-key magit-status-mode-map (kbd "C-f") 'evil-scroll-page-down)
;;      ))
(define-key dired-mode-map (kbd "?") 'evil-search-backward)
(define-key dired-mode-map (kbd "-") 'dired-up-directory) 

(provide 'robenkleene-dired)
