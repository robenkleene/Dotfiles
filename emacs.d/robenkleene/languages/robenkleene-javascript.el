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


    ;; Run Map
    (defvar robenkleene/javascript-run-leader-map (make-keymap))
    (define-key robenkleene/javascript-run-leader-map (kbd "b")
      (lambda () (interactive)
        (robenkleene/evil-execute-command "!node %")
        ))
    (define-key robenkleene/javascript-run-leader-map (kbd "r")
      (lambda () (interactive)
        (robenkleene/evil-execute-command "'<,'>w !node")
        ))

    ;; JavaScript Leader Map
    (defvar robenkleene/javascript-leader-map (make-keymap))
    (define-key robenkleene/javascript-leader-map (kbd "l") robenkleene/javascript-repl-leader-map)
    (define-key robenkleene/javascript-leader-map (kbd "s") 'helm-semantic-or-imenu)
    (define-key robenkleene/javascript-leader-map (kbd "r") robenkleene/javascript-run-leader-map)

    ;; Add Map to mode
    (declare-function evil-declare-key "evil")
    (evil-declare-key 'motion js2-mode-map (kbd ",") robenkleene/javascript-leader-map)

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

        ;; Map function to evaluate region
        (define-key robenkleene/javascript-repl-leader-map (kbd "r") (lambda (begin end)
                                                                       (interactive "r")
                                                                       (robenkleene/nodejs-repl-eval-region begin end)
                                                                       (deactivate-mark)
                                                                       ))
        (define-key robenkleene/javascript-repl-leader-map (kbd "b") 'robenkleene/nodejs-repl-eval-buffer)
        
        )
      )
    )
  )

(provide 'robenkleene-javascript)
;;; robenkleene-javascript.el ends here
