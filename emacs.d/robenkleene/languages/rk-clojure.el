(rk-install-package-if-missing 'nrepl)

(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'nrepl-mode-hook  'paredit-mode)

(eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "s-r") 'rk-nrepl-eval-buffer-or-region)
     (define-key clojure-mode-map (kbd "C-S-e") 'nrepl-eval-last-expression)
     (define-key clojure-mode-map (kbd "<C-s-268632082>") 'rk-clojure-toggle-repl) 
     (define-key clojure-mode-map (kbd "C-s-r") 'rk-clojure-toggle-repl)
     ))


(defun rk-nrepl-eval-buffer-or-region ()
  (interactive)
  (if (use-region-p)
      (call-interactively 'nrepl-eval-region)
    (nrepl-load-current-buffer)))

;; (nrepl-quit)
;; (nrepl-backward-input) Jump backwards in input history

(eval-after-load "nrepl"
  '(progn
     (define-key nrepl-mode-map (kbd "C-n") 'nrepl-forward-input)
     (define-key nrepl-mode-map (kbd "C-p") 'nrepl-backward-input)
     ))

(defun rk-clojure-toggle-repl ()
  (interactive)
  (if (null (get-buffer "*nrepl*"))
      (rk-clojure-start-repl)
    (rk-clojure-stop-repl)))
(defun rk-clojure-start-repl ()
  (interactive)
  (add-hook 'nrepl-connected-hook 'rk-window-resize-for-shell)
  (nrepl-jack-in)
;;  (remove-hook 'nrepl-connected-hook 'rk-window-resize-for-shell)
  )
;;  (add-hook 'nrepl-disconnected-hook ')
(defun rk-clojure-stop-repl ()
  (interactive)
  (nrepl-quit))


(provide 'rk-clojure)
