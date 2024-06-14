;;; robenkleene-search.el --- robenkleene-search
;;; Commentary:
;;; Code:

;; Make isearch wrap automatically
;; Prevents issue with automatic wrapping where you have to press backspace
;; twice when trying to remove the first character that fails a search
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)
(defadvice isearch-search (after rk/isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'rk/isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'rk/isearch-no-fail)
    (ad-activate 'isearch-search)))

(provide 'robenkleene-search)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-search.el ends here
