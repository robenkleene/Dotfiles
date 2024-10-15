;;; robenkleene-text.el --- robenkleene-text
;;; Commentary:
;;; Code:

(with-eval-after-load 'text-mode
  ;; Add characters to wrap on (in particular this helps URLs wrap more naturally)
  (setq rk/text-category-table (copy-category-table))
  (modify-category-entry ?- ?| rk/text-category-table)
  (modify-category-entry ?/ ?| rk/text-category-table)
  ;; It looks funny to have line breaks on `:`, `.` and `,` in normal prose
  ;; (modify-category-entry ?. ?| rk/text-category-table)
  ;; (modify-category-entry ?, ?| rk/text-category-table)
  ;; (modify-category-entry ?: ?| rk/text-category-table)
  (modify-category-entry ?_ ?| rk/text-category-table)
  (add-hook 'text-mode-hook (lambda ()
                              ;; Wrap in text modes
                              (set 'truncate-lines nil)
                              (set-category-table rk/text-category-table)
                              (setq-local word-wrap-by-category t)
                              ;; Show trailing whitespace
                              (setq-local show-trailing-whitespace t)
                              ))

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



  ;; Allow following grep line matches
  (define-key text-mode-map (kbd "C-x C-f") 'ffap)
  ;; (define-key text-mode-map (kbd "M-<down>") 'rk/move-line-down)
  ;; (define-key text-mode-map (kbd "M-<up>") 'rk/move-line-up)
  ;; Make is so quotes and double quotes can be selected with `mark-sexp'
  (modify-syntax-entry ?' "\"")
  (modify-syntax-entry ?\" "\"")
  )

(provide 'robenkleene-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-text.el ends here
