;;; robenkleene-evil-functions.el --- robenkleene-evil-functions
;;; Commentary:
;;; Code:

(require 'evil-commands)

(defmacro robenkleene/advice-after-evil-initial-state (func)
  "Takes a FUNC, set the buffer to evil initial state after."
  `(defadvice ,func (after robenkleene/after-evil-initial-state activate)
     (evil-change-to-initial-state)
     )
  )

(evil-define-command robenkleene/evil-rename (new-filename &optional bang)
  :repeat nil
  :move-point nil
  (interactive "<f><!>")
  (let ((name (buffer-name))
        (old-filename (buffer-file-name)))
    (if (not old-filename)
        (message "Buffer '%s' is not visiting a file!" name)
        (progn
          (rename-file name new-filename bang)
          (kill-buffer new-filename)
          (rename-buffer new-filename)
          (set-visited-file-name new-filename)
          (set-buffer-modified-p nil)
          )
        )
      )
    )

(evil-ex-define-cmd "Rename" 'robenkleene/evil-rename)

(provide 'robenkleene-evil-functions)
;;; robenkleene-evil-functions.el ends here
