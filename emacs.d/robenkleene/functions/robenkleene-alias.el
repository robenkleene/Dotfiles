;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

(defalias 'yg 'yank-to-grep-buffer)
(defalias 'u 'rk/egit-update)
(defalias 'ut 'rk/git-pull-all-text)

(defalias 'yd 'yank-to-diff-buffer)
(defalias 'yg 'yank-to-grep-buffer)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
