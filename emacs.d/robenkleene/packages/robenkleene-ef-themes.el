;;; robenkleene-ef-themes.el --- robenkleene-ef-themes
;;; Commentary:
;;; Code:

(use-package ef-themes
  :config

  (if (and (not (display-graphic-p)) (string= (getenv "THEME") "dark"))
      (load-theme 'ef-owl)
    (load-theme 'ef-eagle)
    )

  )

(provide 'robenkleene-ef-themes)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-ef-themes.el ends here
