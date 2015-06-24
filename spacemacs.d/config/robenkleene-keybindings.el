;;; robenkleene-keybinding.el --- robenkleene-keybinding
;;; Commentary:
;;; Code:

(defmacro robenkleene-rsify (mode map)
  "Hurt your hands in MODE and MAP."
  `(eval-after-load ,mode
     '(progn
        (define-key ,map (kbd "C-w") 'backward-kill-word)
        (define-key ,map (kbd "C-u") '(lambda () (interactive) (kill-line 0)))
        )
     )
  )
(defvar helm-swoop-map)
(defvar helm-map)
(defvar helm-grep-map)
(robenkleene-rsify 'helm-swoop helm-swoop-map)
(robenkleene-rsify 'helm helm-map)
(robenkleene-rsify 'helm-grep helm-grep-map)

;; Define C-u & C-w in isearch
;; (defun robenkleene/isearch-delete-line ()
;;   "Delete line."
;;   (interactive "p")
;;   (if (= 0 (length isearch-string))
;;       (ding)
;;     (setq isearch-string "")
;;           isearch-message (mapconcat 'isearch-text-char-description
;;                                      isearch-string ""))
;;   (if isearch-other-end (goto-char isearch-other-end))
;;   (isearch-search)
;;   (isearch-push-state)
;;   (isearch-update))
(defun robenkleene/isearch-delete-line (&optional arg)
  "Delete character from end of search string and search again.
Unlike `isearch-delete-char', it only deletes the last character,
but doesn't cancel the effect of other isearch command.
If search string is empty, just beep."
  (interactive "p")
  (if (= 0 (length isearch-string))
      (ding)
    (setq isearch-string ""
          ;; (substring isearch-string 0
				  ;;   (- (min (or arg 1)
					;;     (length isearch-string))))
          isearch-message (mapconcat 'isearch-text-char-description
                                     isearch-string "")))
  ;; Use the isearch-other-end as new starting point to be able
  ;; to find the remaining part of the search string again.
  ;; This is like what `isearch-search-and-update' does,
  ;; but currently it doesn't support deletion of characters
  ;; for the case where unsuccessful search may become successful
  ;; by deletion of characters.
  (if isearch-other-end (goto-char isearch-other-end))
  (isearch-search)
  (isearch-push-state)
  (isearch-update))




(require 's)
(defun robenkleene/isearch-delete-word ()
  "Delete word in the `isearch-string'.  Splitting strings by whitespace, dashes, underscores and camelcase."
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
(define-key isearch-mode-map (kbd "C-u") 'robenkleene/isearch-delete-line)
(define-key isearch-mode-map (kbd "C-w") 'robenkleene/isearch-delete-word)

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

;;; robenkleene-keybindings.el ends here
