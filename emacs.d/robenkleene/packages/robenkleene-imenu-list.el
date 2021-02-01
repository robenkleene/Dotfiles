;;; robenkleene-imenu-list.el --- robenkleene-imenu-list
;;; Commentary:
;;; Code:

(use-package imenu-list
  :ensure t
  :bind
  (:map robenkleene/leader-map
        ("M-i" . imenu-list-smart-toggle)
        )
  :config
  (setq imenu-list-focus-after-activation t
        imenu-list-auto-resize nil))

(provide 'robenkleene-imenu-list)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-imenu-list.el ends here
