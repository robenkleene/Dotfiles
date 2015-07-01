;;; robenkleene-keybinding.el --- robenkleene-keybinding
;;; Commentary:
;;; Code:

;;; RSI
;; Helm
(require 'robenkleene-functions)

;; Helm
(defvar helm-swoop-map)
(robenkleene/rsify 'helm-swoop helm-swoop-map
                   (define-key helm-swoop-map (kbd "M-w") 'helm-swoop-yank-thing-at-point)
                   )
(defvar helm-map)
(robenkleene/rsify 'helm helm-map
                   (define-key helm-map (kbd "M-w") 'helm-yank-text-at-point)
                   )
(defvar helm-grep-map)
(robenkleene/rsify 'helm-grep helm-grep-map
                   (define-key helm-grep-map (kbd "M-w") 'helm-yank-text-at-point)
                   )
(defvar helm-generic-files-map)
(robenkleene/rsify 'helm helm-generic-files-map)
;; Company
(defvar company-active-map)
(robenkleene/rsify 'company company-active-map
                   (define-key company-active-map (kbd "M-w") 'company-show-location)
                   )

;; isearch
(define-key isearch-mode-map (kbd "C-u") 'robenkleene/isearch-delete-line)
(define-key isearch-mode-map (kbd "C-w") 'robenkleene/isearch-delete-word)
;; Everything else
(defvar robenkleene-rsi-minor-mode-map (make-keymap))
(define-key robenkleene-rsi-minor-mode-map (kbd "C-w") 'robenkleene/kill-region-or-backward-word)
(define-key robenkleene-rsi-minor-mode-map (kbd "C-u") 'robenkleene/backward-delete-line)
(define-minor-mode robenkleene-rsi-minor-mode
  "Get rsi."
  t
  nil
  'robenkleene-rsi-minor-mode-map)
(robenkleene-rsi-minor-mode 1)

;; Insert Mode Keys
;; TODO: Figure out how to not clobber clipboard when specifying paths for helm search
;; (define-key minibuffer-local-map (kbd "C-w") 'robenkleene/backward-delete-word)

;; Use Hippie Expand over Dabbrev `M-/'
(global-set-key [remap dabbrev-expand] 'hippie-expand)

(provide 'robenkleene-keybindings)
;;; robenkleene-keybindings.el ends here
