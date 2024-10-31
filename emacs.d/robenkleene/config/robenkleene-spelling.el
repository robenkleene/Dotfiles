;;; robenkleene-spelling.el --- robenkleene-spelling
;;; Commentary:
;;; Code:

(with-eval-after-load 'flyspell-mode
  ;; Spelling
  (setq ispell-program-name "aspell")
  (setq ispell-dictionary "english")

  ;; Don't prompt when saving a word to the dictionary
  (setq ispell-silently-savep t)

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

(add-hook 'text-mode-hook 'flyspell-mode)

(provide 'robenkleene-spelling)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-spelling.el ends here
