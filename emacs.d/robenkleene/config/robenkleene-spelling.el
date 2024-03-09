;;; robenkleene-spelling.el --- robenkleene-spelling
;;; Commentary:
;;; Code:

;; Spelling
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")

;; This is way too noisy
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
(setq flyspell-issue-message-flag nil)
;; Don't prompt when saving a word to the dictionary
(setq ispell-silently-savep t)

(provide 'robenkleene-spelling)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-spelling.el ends here
