;;; robenkleene-grep.el --- robenkleene-grep
;;; Commentary:
;;; Code:

(add-hook 'grep-mode-hook (lambda ()
                            (pop-to-buffer (get-buffer "*grep*"))
                            (define-key grep-mode-map (kbd "M-n")
                              'next-error)
                            (define-key grep-mode-map (kbd "M-p")
                              'previous-error)
                            )
          )

;; Automatically go to first line of matches
(setq compilation-finish-functions
      (append compilation-finish-functions
              '(lambda (buffer status)
                 (cond
                  ((eq major-mode 'grep-mode) (forward-line 4))
                  ;; ((eq major-mode 'occur-mode) (forward-line 1))
                  )
                 )))

(provide 'robenkleene-grep)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-grep.el ends here
