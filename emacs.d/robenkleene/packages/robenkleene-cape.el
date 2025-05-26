;;; robenkleene-cape.el --- robenkleene-cape
;;; Commentary:
;;; Code:

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (use-package yasnippet-capf
    :init
    (add-to-list 'completion-at-point-functions #'yasnippet-capf)
    )

  ;; Exclusive

  ;; When `completion-at-point-functions' is with the last element as true it's
  ;; supposed to go from the local to global value of
  ;; `completion-at-point-fucntions'
  ;; But if a completion function is marked as `exclusive', then if it handles a
  ;; completion, the rest of the functions are skipped
  ;; The `cape' completions are marked not marked as exclusive, but the default
  ;; ones typically are
  ;; So after major mode change we iterate through all the
  ;; `completion-at-point-fucntions' local to that mode and make them not
  ;; exclusive
  (defun rk/make-all-capf-non-exclusive (capf-list)
    "Ensure all CAPFs in CAPF-LIST are non-exclusive, except the last element if
it's `t`."
    ;; Check if the last element is `t`, and modify the rest
    (let* ((last-element (car (last capf-list)))
           (capf-list-to-modify (if (eq last-element t)
                                    (butlast capf-list)
                                  capf-list)))
      (append
       (mapcar (lambda (capf)
                 (cape-capf-properties capf :exclusive 'no))
               capf-list-to-modify)
       (if (eq last-element t) (list t)))))

  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (when (local-variable-p 'completion-at-point-functions)
                (setq-local completion-at-point-functions
                            (rk/make-all-capf-non-exclusive
                             completion-at-point-functions)))))
  )

(provide 'robenkleene-cape)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-cape.el ends here
