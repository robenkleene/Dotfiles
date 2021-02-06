;;; robenkleene-flimenu.el --- robenkleene-flimenu
;;; Commentary:
;;; Code:

(use-package flimenu
  :commands flimenu-mode
  :init
  (add-hook 'markdown-mode-hook 'flimenu-mode)
  )

(provide 'robenkleene-flimenu)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-flimenu.el ends here
