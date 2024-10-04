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
  ;; So we need to manually mark them as not exclusive here.
  (add-hook
   'emacs-lisp-mode-hook
   (lambda ()
     (setq-local completion-at-point-functions
                 (list (cape-capf-properties  #'elisp-completion-at-point
                                              :exclusive
                                              'no) t))))
  )



(provide 'robenkleene-cape)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-cape.el ends here
