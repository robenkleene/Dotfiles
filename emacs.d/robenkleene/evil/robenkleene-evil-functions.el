;;; robenkleene-evil-functions.el --- robenkleene-evil-functions
;;; Commentary:
;;; Code:


(defmacro robenkleene/advice-after-evil-initial-state (func)
  "Takes a FUNC, set the buffer to evil initial state after."
  `(defadvice ,func (after robenkleene/after-evil-initial-state activate)
     (evil-change-to-initial-state)
     )
  )

(provide 'robenkleene-evil-functions)
;;; robenkleene-evil-functions.el ends here
