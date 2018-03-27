;;; robenkleene-undo-tree.el --- robenkleene-undo-tree
;;; Commentary:
;;; Code:

(use-package undo-tree
  :commands (undo-tree-visualize)
  :init
  (global-undo-tree-mode 1)
  )

(provide 'robenkleene-undo-tree)
;;; robenkleene-undo-tree.el ends here
