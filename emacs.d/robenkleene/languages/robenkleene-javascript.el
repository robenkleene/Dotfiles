;;; robenkleene-javascript.el --- robenkleene-javascript
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package js2-mode
  :mode "\\.js\\'"
  :config
  ;; Node REPL
  (use-package nodejs-repl
    :commands nodejs-repl
    :config
    (defun robenkleene/nodejs-repl-eval-region (start end)
      "Evaluate the region specified by `START' and `END'."
      (let ((proc (get-process nodejs-repl-process-name)))
        (comint-simple-send proc (buffer-substring-no-properties start end))))
    
    (defun robenkleene/nodejs-repl-eval-buffer (&optional buffer)
      "Evaluate the current buffer or the one given as `BUFFER'.  `BUFFER' should be a string or buffer."
      (interactive)
      (let ((buffer (or buffer (current-buffer))))
        (with-current-buffer buffer
          (robenkleene/nodejs-repl-eval-region (point-min) (point-max)))))

    (defun robenkleene/nodejs-repl-eval-region-or-buffer ()
      "Evaluate the region if it's active, otherwise the buffer."
      (interactive)
      (if (region-active-p)
          (progn
            (robenkleene/nodejs-repl-eval-region (region-beginning) (region-end))
            (deactivate-mark)
            )
        (robenkleene/nodejs-repl-eval-buffer)
        )
      )
    )
  )

(provide 'robenkleene-javascript)
;;; robenkleene-javascript.el ends here
