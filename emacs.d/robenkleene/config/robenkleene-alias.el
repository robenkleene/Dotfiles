;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

;; Shorthand
(defalias 'oi 'robenkleene/edit-init)
(defalias 'yg 'robenkleene/grep-from-clipboard)
(defalias 'doc 'robenkleene/consult-doc)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-p")))
(defalias 'u 'robenkleene/egit-update)

;; Consistent
(defalias 'switch-to-eshell 'eshell)

;; Vim
;; (defalias 'bd 'kill-this-buffer)
;; (defalias 'new 'robenkleene/switch-to-empty-buffer-other-window)
;; (defalias 'vnew 'robenkleene/switch-to-empty-buffer-other-window-right)
;; (defalias 'enew 'robenkleene/switch-to-empty-buffer)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
