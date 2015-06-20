
;; TODO: A function that defines the `C-w` binding in all of these modes (i.e., "rsify"):
;; minibuffer-local-map, helm-map, helm-etags-map,helm-moccur-map, helm-generic-files-map, helm-grep-map, helm-pdfgrep-map, now-map 

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
