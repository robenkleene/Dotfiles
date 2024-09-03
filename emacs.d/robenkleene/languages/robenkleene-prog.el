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
  (define-key prog-mode-map (kbd "C-x C-f") 'ffap)
  ;; (define-key prog-mode-map (kbd "M-<down>") 'rk/move-line-down)
  ;; (define-key prog-mode-map (kbd "M-<up>") 'rk/move-line-up)
  )

(add-hook 'prog-mode-hook (lambda ()
                            (display-line-numbers-mode)
                            ;; Show trailing whitespace
                            (setq-local show-trailing-whitespace t)
                            (rk/highlight-keywords)
                            (display-fill-column-indicator-mode)
                            ))

;; Only show line numbers in programming modes
;; Don't show line numbers in GUI mode because of that bug where the line with
;; the cursor sometimes gets offset slightly
;; (unless window-system
;;   (global-display-line-numbers-mode 1)
;;   ;; This looks janky
;;   ;; (add-hook 'prog-mode-hook 'display-line-numbers-mode)
;;   )

(provide 'robenkleene-prog)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-prog.el ends here
