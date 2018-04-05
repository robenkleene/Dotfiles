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
;;; robenkleene-iedit.el ends here
