;;; robenkleene-move-text.el --- robenkleene-move-text
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package move-text
  :ensure t
  :commands (move-text-up move-text-down)
  :bind
  ("M-<down>" . robenkleene/move-text-or-region-down)
  ("M-<up>" . robenkleene/move-text-or-region-up)
  :init
  (defun robenkleene/move-text-or-region-up ()
    "Move text or region up."
    (interactive)
    (if (use-region-p)
        (call-interactively 'move-text-up)
      (robenkleene/move-line-up)
      )
    )
  (defun robenkleene/move-text-or-region-down ()
    "Move text or region up."
    (interactive)
    (if (use-region-p)
        (call-interactively 'move-text-down)
      (robenkleene/move-line-down)
      )
    )
  )

(provide 'robenkleene-move-text)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-move-text.el ends here
