;;; robenkleene-css.el --- robenkleene-css
;;; Commentary:
;;; Code:

(add-hook 'scss-mode-hook
          (lambda ()
            (setq-local robenkleene/format-program "prettier --parser scss"))
          (when (boundp 'whitespace-style)
            (setq-local whitespace-style (push 'lines-tail
                                               whitespace-style)))
          )

(provide 'robenkleene-css)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-css.el ends here
