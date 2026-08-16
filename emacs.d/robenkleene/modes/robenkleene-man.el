;;; robenkleene-man.el --- robenkleene-man
;;; Commentary:
;;; Code:

;; Including these lines suppresses the error `Warning (defvaralias):
;; Overwriting value of ‘woman-topic-history’ by aliasing to
;; ‘Man-topic-history’' the first time `woman' is run
;; We should periodically try removing this
(defvaralias 'woman-topic-history 'Man-topic-history)
(defvar woman-file-history nil "File-name read history.")
;; Use `woman' prompt for man page completion (the default man page completion
;; always stalls, and the `woman' rendering has trouble with `pandoc' generated
;; `man' pages. Combining `woman' completion, and `man' rendering works well.)
(defadvice man (before rk/woman-prompt activate)
  (interactive (progn
                 (require 'woman)
                 (list (woman-file-name nil)))))

(setq Man-notify-method 'pushy)

;; This doesn't work because it results in the selected man page name (e.g.,
;; `rk-emacs') also being passed to the lambda function instead of being passed
;; to the `man' called next
;; (advice-add 'man
;;             :before
;;             #'(lambda () (interactive
;;                           (progn
;;                             (require 'woman)
;;                             (list (woman-file-name nil))))))

(provide 'robenkleene-man)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-man.el ends here
