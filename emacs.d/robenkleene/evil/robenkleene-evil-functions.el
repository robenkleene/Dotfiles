;;; robenkleene-evil-functions.el --- robenkleene-evil-functions
;;; Commentary:
;;; Code:

(require 'evil-commands)

(defun robenkleene/evil-execute-command (command)
  "Execute COMMAND as ex command."
  (let ((evil-ex-current-buffer (current-buffer))
        result)
    (evil-ex-execute command)
    )
  )

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
        (if (get-buffer new-filename)
            (kill-buffer new-filename)
          )
        (rename-buffer new-filename)
        (set-visited-file-name new-filename)
        (set-buffer-modified-p nil)
        )
      )
    )
  )

(evil-define-command robenkleene/evil-remove ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(evil-ex-define-cmd "Rename" 'robenkleene/evil-rename)
(evil-ex-define-cmd "Remove" 'robenkleene/evil-remove)

(provide 'robenkleene-evil-functions)
;;; robenkleene-evil-functions.el ends here
