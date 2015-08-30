;;; robenkleene-swift.el --- robenkleene-swift
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package swift-mode
  :ensure t
  :defer t
  :init
  (progn
    ;; Eval Map
    (defvar robenkleene/swift-leader-map (make-keymap))
    (define-key robenkleene/swift-leader-map (kbd "x") 'robenkleene/open-in-xcode)

    ;; Add map to mode
    (defvar swift-mode-map)
    (declare-function evil-declare-key "evil")
    (evil-declare-key 'motion swift-mode-map (kbd "\\") robenkleene/swift-leader-map)
    )

  )

(provide 'robenkleene-swift)
;;; robenkleene-swift.el ends here
