
;; Potential maps to override
;; minibuffer-local-map, helm-map, helm-etags-map,helm-moccur-map, helm-generic-files-map, helm-grep-map, helm-pdfgrep-map, now-map 
(defmacro robenkleene-rsify (mode map)
  `(eval-after-load ,mode
    '(progn
       (define-key ,map (kbd "C-w") 'backward-kill-word)
       (define-key ,map (kbd "C-u") '(lambda () (interactive) (kill-line 0)))
       )
    )
  )
(robenkleene-rsify 'helm-swoop helm-swoop-map)
(robenkleene-rsify 'helm helm-map)
(robenkleene-rsify 'helm-grep helm-grep-map)

(defvar robenkleene-rsi-minor-mode-map (make-keymap))
(define-key robenkleene-rsi-minor-mode-map (kbd "C-w") 'backward-kill-word)
(define-key robenkleene-rsi-minor-mode-map (kbd "C-u") '(lambda () (interactive) (kill-line 0)))
(define-minor-mode robenkleene-rsi-minor-mode
  "Navigation like OS X."
  t
  nil
  'robenkleene-rsi-minor-mode-map)
(robenkleene-rsi-minor-mode 1)
(provide 'robenkleene-keybindings)
