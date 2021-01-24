;;; robenkleene-iedit.el --- robenkleene-iedit
;;; Commentary:
;;; Code:

(use-package iedit
  :commands (iedit-mode)
  :bind
  (:map robenkleene/leader-map
        (";" . iedit-mode)
        ("C-;" . iedit-mode)
        )
  )

(provide 'robenkleene-iedit)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-iedit.el ends here
