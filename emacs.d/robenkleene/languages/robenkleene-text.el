;;; robenkleene-text.el --- robenkleene-text
;;; Commentary:
;;; Code:

;; Goto grep line number and use `find-file-at-point' by default
(defun rk/find-file-at-point-goto-line (ret)
  "Ignore RET and jump to line number given in `ffap-string-at-point'."
  (when (and
         (stringp ffap-string-at-point)
         (string-match ":\\([0-9]+\\)" ffap-string-at-point))
    (goto-line (string-to-number (match-string 1 ffap-string-at-point)))
    )
  ret)
(advice-add 'find-file-at-point :filter-return #'rk/find-file-at-point-goto-line)
;; This also binds for `dired-mode', which isn't desirable
;; (ffap-bindings)

(with-eval-after-load 'text-mode
  ;; Allow following grep line matches
  (define-key text-mode-map (kbd "C-x C-f") 'ffap)
  ;; Make is so quotes and double quotes can be selected with `mark-sexp'
  (modify-syntax-entry ?' "\"")
  (modify-syntax-entry ?\" "\"")
  )

;; Add characters to wrap on (in particular this helps URLs wrap more naturally)
(setq rk/text-category-table (copy-category-table))
(modify-category-entry ?- ?| rk/text-category-table)
(modify-category-entry ?/ ?| rk/text-category-table)
(modify-category-entry ?. ?| rk/text-category-table)
(modify-category-entry ?, ?| rk/text-category-table)
(modify-category-entry ?_ ?| rk/text-category-table)
(modify-category-entry ?: ?| rk/text-category-table)
(add-hook 'text-mode-hook (lambda ()
                            ;; Wrap in text modes
                            (set 'truncate-lines nil)
                            (set-category-table rk/text-category-table)
                            (setq-local word-wrap-by-category t)
                            ;; Spelling
                            (flyspell-mode)
                            ;; Show trailing whitespace
                            (setq-local show-trailing-whitespace t)
                            ))

(provide 'robenkleene-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-text.el ends here
