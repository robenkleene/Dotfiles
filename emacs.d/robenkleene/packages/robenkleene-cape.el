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
