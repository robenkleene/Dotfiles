;;; robenkleene-window-management.el --- robenkleene-window-management
;;; Commentary:
;;; Code:

;; Window Management
;; Make display buffer rules more consistent
(setq switch-to-buffer-obey-display-actions t)

;; Automatically select some types of buffers
;; Unnecessary with below automatic switch to buffer
;; But still helps because it's less buggy
(setq help-window-select t)

;; Just automatically always select new buffers
;; This works to target automatically focus all popups, but it breaks magit
;; commit
;; (defun rk/switch-to-buffer (buffer alist)
;;   (let* (
;;          (window (display-buffer-reuse-window
;;                   buffer alist))
;;          ;; With two frames side-by-side, this will open the buffer in both
;;          ;; frames!?
;;          ;; (window (or window (display-buffer-use-least-recent-window
;;          ;;                     buffer alist)))
;;          (window (or window (display-buffer-pop-up-window
;;                              buffer alist)))
;;          ;; (window (or window (get-buffer-window buffer)))
;;          )
;;     (if (window-live-p window)
;;         (select-window window)
;;       )
;;     )
;;   )


;; (setq display-buffer-alist
;;       '(
;;         ("[ ]?[*][^*]+[*]" (rk/switch-to-buffer))
;;         )
;;       )

;; Theoretically this is better than the above, because at least sometimes this
;; should re-use buffers?
(defadvice display-buffer (after rk/display-buffer-select (buffer &optional action frame) activate)
  "Wrapper function description."
  (if buffer
      (let (
            (window (get-buffer-window buffer))
            )
        (if (window-live-p window)
            (select-window window)
          )
        )
    )
  )

(provide 'robenkleene-window-management)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-window-management.el ends here
