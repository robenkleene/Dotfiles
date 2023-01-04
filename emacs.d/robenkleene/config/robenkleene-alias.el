;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

;; Shorthand
(defalias 'oi 'rk/edit-init)
(defalias 'yg 'rk/grep-from-clipboard)
(defalias 'doc 'rk/consult-doc)
(defalias 'scw 'rk/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (rk/source-control-open-web "-p")))
(defalias 'u 'rk/egit-update)

;; Consistent
(defalias 'switch-to-eshell 'eshell)

;; Vim
;; (defalias 'bd 'kill-this-buffer)
;; (defalias 'new 'rk/switch-to-empty-buffer-other-window)
;; (defalias 'vnew 'rk/switch-to-empty-buffer-other-window-right)
;; (defalias 'enew 'rk/switch-to-empty-buffer)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
