;;; robenkleene-undo-tree.el --- robenkleene-undo-tree
;;; Commentary:
;;; Code:

(use-package undo-tree
  :commands (undo-tree-visualize)
  :init
  (global-undo-tree-mode 1)
  ; Prevent files from being placed everywhere
  (setq undo-tree-auto-save-history nil)
  )

(provide 'robenkleene-undo-tree)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-undo-tree.el ends here
