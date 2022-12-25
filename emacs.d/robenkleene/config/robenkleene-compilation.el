;;; robenkleene-compilation.el --- robenkleene-compilation
;;; Commentary:
;;; Code:

(setq compile-command nil)
(ignore-errors
  (require 'ansi-color)
  (defun robenkleene/colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'robenkleene/colorize-compilation-buffer))

(provide 'robenkleene-compilation)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-compilation.el ends here
