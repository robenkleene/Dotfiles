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
  )

(provide 'robenkleene-cape)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-cape.el ends here
