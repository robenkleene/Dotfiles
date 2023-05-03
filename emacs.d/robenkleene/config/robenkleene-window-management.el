;;; robenkleene-window-management.el --- robenkleene-window-management
;;; Commentary:
;;; Code:

;; Window Management
;; Make display buffer rules more consistent
(setq switch-to-buffer-obey-display-actions t)

;; Automatically select some types of buffers
(setq help-window-select t)

;; Just automatically always select new buffers
;; This works to target automatically focus all popups, but it breaks magit
;; commit
;; (defun rk/switch-to-buffer (buffer alist)
;;   (select-window (display-buffer-pop-up-window
;;                   buffer alist)))
;; (setq display-buffer-alist
;;       '(("[ ]?[*][^*]+[*]" (rk/switch-to-buffer))))

(provide 'robenkleene-window-management)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-window-management.el ends here
