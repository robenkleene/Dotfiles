(rk-install-package-if-missing 'nrepl)

(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'nrepl-mode  #'enable-paredit-mode)

(eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "s-r") 'rk-nrepl-eval-buffer-or-region)
     (define-key clojure-mode-map (kbd "C-E") 'nrepl-eval-last-expression)
     ))


(defun rk-nrepl-eval-buffer-or-region ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'nrepl-eval-region)
    (nrepl-load-current-buffer)))

;; (nrepl-quit)
;; (nrepl-backward-input) Jump backwards in input history

(eval-after-load 'nrepl-mode
  '(progn
     (define-key nrepl-mode-map (kbd "C-n") 'nrepl-forward-input)
     (define-key nrepl-mode-map (kbd "C-p") 'nrepl-backward-input)
     ))

;; (defun rk-clojure ()
;;   (interactive)
;;   (nrepl-jack-in)
;;   (rk-window-resize-for-shell)
;;   )

(provide 'rk-clojure)
