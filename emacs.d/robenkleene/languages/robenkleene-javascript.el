;;; robenkleene-javascript.el --- robenkleene-javascript
;;; Commentary:
;;; Code:

(require 'robenkleene-evil-functions)
(require 'use-package)
(use-package js2-mode
  :ensure t
  :init
  :mode "\\.js\\'"
  :config
  (progn
    ;; Repl Map
    (defvar robenkleene/javascript-repl-leader-map (make-keymap))
    (define-key robenkleene/javascript-repl-leader-map (kbd "o") 'nodejs-repl)


    (defun robenkleene/run-javascript-region-or-buffer ()
      "Open a region or file in external editor.  BEGIN and END are the region."
      (interactive)
      (if (use-region-p)
          (progn
            (robenkleene/evil-execute-command "'<,'>w !node")
            )
        (if (buffer-file-name)
            (robenkleene/evil-execute-command "!node %")
          )
        )
      )

    ;; JavaScript Leader Map
    (defvar robenkleene/javascript-leader-map (make-keymap))
    (define-key robenkleene/javascript-leader-map (kbd "l") robenkleene/javascript-repl-leader-map)
    (define-key robenkleene/javascript-leader-map (kbd "s") 'helm-semantic-or-imenu)
    (define-key robenkleene/javascript-leader-map (kbd "r") 'robenkleene/run-javascript-region-or-buffer)
    (define-key robenkleene/javascript-leader-map (kbd "p") 'robenkleene/print-variable)
    (define-key robenkleene/javascript-leader-map (kbd "C") 'compile)
    (define-key robenkleene/javascript-leader-map (kbd "c") 'recompile)

    ;; Add Map to mode
    (declare-function evil-declare-key "evil")
    (evil-declare-key 'motion js2-mode-map (kbd "\\") robenkleene/javascript-leader-map)

    ;; Node REPL
    (use-package nodejs-repl
      :ensure t
      :commands nodejs-repl
      :config
      (progn
        ;; Define function to evaluate region
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
        
        ;; Map function to evaluate region
        (define-key robenkleene/javascript-repl-leader-map (kbd "r") 'robenkleene/nodejs-repl-eval-region-or-buffer)
        )
      )
    )
  )

(provide 'robenkleene-javascript)
;;; robenkleene-javascript.el ends here
