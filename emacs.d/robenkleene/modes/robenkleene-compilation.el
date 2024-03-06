;;; robenkleene-compilation.el --- robenkleene-compilation
;;; Commentary:
;;; Code:

(setq compile-command nil)
(ignore-errors
  (require 'ansi-color)
  (defun rk/colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'rk/colorize-compilation-buffer))

;; (add-hook 'compilation-mode-hook (lambda ()
;;                                    (pop-to-buffer (get-buffer "*compilation*"))
;;                                    (define-key compilation-mode-map (kbd "M-n")
;;                                      'next-error)
;;                                    (define-key compilation-mode-map (kbd "M-p")
;;                                      'previous-error)
;;                                    )
;;           )

;; (with-eval-after-load 'compilation
;;   (define-key compilation-mode-map (kbd "M-n")
;;               'next-error)
;;   (define-key compilation-mode-map (kbd "M-p")
;;               'previous-error)
;;   )

;; Keep the error highlight until another command (without this the highlighted
;; line gets cleared, e.g., conflicting with `hg-line-mode')
;; (setq next-error-highlight t)

(provide 'robenkleene-compilation)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-compilation.el ends here
