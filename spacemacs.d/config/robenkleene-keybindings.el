
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


;; (defun robenkleene/isearch-delete-line ()
;;   (interactive "p")
;;   (if (= 0 (length isearch-string))
;;       (ding)
;;     (setq isearch-string "")
;;           isearch-message (mapconcat 'isearch-text-char-description
;;                                      isearch-string "")))
;; (if isearch-other-end (goto-char isearch-other-end))
;; (isearch-search)
;; (isearch-push-state)
;; (isearch-update)))
(defun robenkleene/isearch-delete-word ()
  "Delete word in the `isearch-string'. Splitting strings by whitespace, dashes, underscores and camelcase."
  (interactive)
  (let* ((isearch-regexp )
         (str (s-with (s-trim-right isearch-string)
                (s-chop-suffixes '("-" "-" "_" "*" "+" "."))))
         (trm (- (length str)
                 (length (car (last (s-split-words str))))))
         (string (substring str 0 trm)))
    (setq isearch-string nil
          isearch-message nil)
    (isearch-yank-string string)))
(define-key isearch-mode-map (kbd "C-w") 'robenkleene/isearch-delete-word)
;; (define-key isearch-mode-map (kbd "C-u") 'robenkleene/isearch-delete-line)

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
