;;; robenkleene-ef-themes.el --- robenkleene-ef-themes
;;; Commentary:
;;; Code:

(use-package ef-themes
  :config
  ;; Don't try to match light dark themes because it's too difficult to work over ssh
  (load-theme 'ef-owl)
  )

(provide 'robenkleene-ef-themes)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ef-themes.el ends here
