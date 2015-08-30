;;; robenkleene-objective-c.el --- robenkleene-objective-c
;;; Commentary:
;;; Code:

(eval-after-load 'cc-mode
  '(progn

     ;; Eval Map
     (defvar robenkleene/objc-leader-map (make-keymap))
     (define-key robenkleene/objc-leader-map (kbd "x") 'robenkleene/open-in-xcode)

     ;; Add map to mode
     (defvar objc-mode-map)
     (declare-function evil-declare-key "evil")
     (evil-declare-key 'motion objc-mode-map (kbd "\\") robenkleene/objc-leader-map)
     )
  )

(provide 'robenkleene-objective-c)
;;; robenkleene-objective-c.el ends here
