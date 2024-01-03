;;; robenkleene-search.el --- robenkleene-search
;;; Commentary:
;;; Code:

;; Make isearch wrap automatically
;; Prevents issue where you have to press backspace twice when
;; trying to remove the first character that fails a search
;; (define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)
;; (defadvice isearch-search (after rk/isearch-no-fail activate)
;;   (unless isearch-success
;;     (ad-disable-advice 'isearch-search 'after 'rk/isearch-no-fail)
;;     (ad-activate 'isearch-search)
;;     (isearch-repeat (if isearch-forward 'forward))
;;     (ad-enable-advice 'isearch-search 'after 'rk/isearch-no-fail)
;;     (ad-activate 'isearch-search)))

;; Use these motions instead of automatically wrapping
(setq isearch-allow-motion t)

;; Make `isearch' repeatable, but this makes editing the string after a search
;; starts harder
;; (defvar isearch-repeat-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "s") #'isearch-repeat-forward)
;;     (define-key map (kbd "r") #'isearch-repeat-backward)
;;     map))
;; (dolist (cmd '(isearch-repeat-forward isearch-repeat-backward))
;;   (put cmd 'repeat-map 'isearch-repeat-map))

(provide 'robenkleene-search)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-search.el ends here
