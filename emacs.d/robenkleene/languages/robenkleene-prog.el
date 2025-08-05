;;; robenkleene-prog.el --- robenkleene-prog
;;; Commentary:
;;; Code:

(defun rk/highlight-keywords ()
  "Highlight keywords."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t)))
  )

(with-eval-after-load 'prog-mode
  ;; Allow following grep line matches
  ;; (define-key prog-mode-map (kbd "C-x C-f") 'ffap)
  (define-key text-mode-map (kbd "C-x C-f") 'rk/find-file)
  )

(add-hook 'prog-mode-hook (lambda ()
                            (display-line-numbers-mode)
                            ;; Show trailing whitespace
                            (setq-local show-trailing-whitespace t)
                            ;; Show tabs
                            (whitespace-mode)
                            (rk/highlight-keywords)
                            (display-fill-column-indicator-mode)
                            ))

(provide 'robenkleene-prog)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-prog.el ends here
