;;; robenkleene-shell.el --- robenkleene-shell
;;; Commentary:
;;; Code:

(eval-after-load 'shell
  '(progn
     (defvar comint-preoutput-filter-functions)
     (add-to-list 'comint-preoutput-filter-functions
                  (lambda (output)
                    (replace-regexp-in-string "\\[[0-9]+[GK]" "" output)))
     ;; Color prompt based on mode
     (add-hook 'evil-normal-state-entry-hook (lambda ()
                                               (custom-set-faces
                                                `(comint-highlight-prompt ((t (:foreground "brightwhite" :background "#005f87" :bold t))))
                                                )))
     (add-hook 'evil-insert-state-entry-hook (lambda ()
                                               (custom-set-faces
                                                `(comint-highlight-prompt ((t (:foreground "#87d787" :background "unspecified-bg" :bold t))))
                                                )))
     )
  )



(provide 'robenkleene-shell)
;;; robenkleene-shell.el ends here
