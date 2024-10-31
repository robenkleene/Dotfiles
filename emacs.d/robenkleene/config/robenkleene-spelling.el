;;; robenkleene-spelling.el --- robenkleene-spelling
;;; Commentary:
;;; Code:

(with-eval-after-load 'flyspell-mode
  ;; Spelling
  (setq ispell-program-name "aspell")
  (setq ispell-dictionary "english")

  (setq flyspell-issue-message-flag nil)
  ;; Don't prompt when saving a word to the dictionary
  (setq ispell-silently-savep t)

  ;; Flyspell

  ;; Disable spell checking for some faces
  (setq flyspell-generic-check-word-predicate
        'rk/flyspell-generic-textmode-verify)
  (defun rk/flyspell-generic-textmode-verify ()
    "Used for `flyspell-generic-check-word-predicate' in text modes."
    (let ((f (get-text-property (- (point) 1) 'face)))
      (not (memq f '(markdown-pre-face
                     markdown-inline-code-face
                     markdown-language-keyword-face)))))
  )

;; Suppress `Starting new Ispell process' messages
;; This doesn't work
;; (advice-add 'ispell-init-process :around #'rk/suppress-messages)
;; (advice-add 'ispell-kill-ispell :around #'rk/suppress-messages)

;; This is way too noisy
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

(add-hook 'text-mode-hook 'flyspell-mode)

(provide 'robenkleene-spelling)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-spelling.el ends here
