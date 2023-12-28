;;; robenkleene-help.el --- robenkleene-help
;;; Commentary:
;;; Code:


;; Automatically jump to first help button
;; In practice, this is odd:
;; 1. Sometimes there isn't a button, so instead it jumps to the back button
;; 2. Sometimes one help points to another, and this only works for the first
;; help buffer loaded
;; (defadvice help-mode-finish
;;     (after rk/help-mode-finish () activate)
;;   (with-current-buffer (get-buffer-create "*Help*")
;;     (forward-button 1)
;;     )
;;   )
;; (add-hook 'occur-hook (lambda ()
;;                         (progn
;;                           (pop-to-buffer (get-buffer "*Occur*"))
;;                           (forward-line 1)
;;                           )
;;                         )
;;           )

(provide 'robenkleene-help)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-help.el ends here
