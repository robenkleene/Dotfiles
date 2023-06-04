;;; robenkleene-window-management.el --- robenkleene-window-management
;;; Commentary:
;;; Code:

;; Window Management
;; Make display buffer rules more consistent
(setq switch-to-buffer-obey-display-actions t)

;; Automatically select some types of buffers
;; Unnecessary with below automatic switch to buffer
;; But still helps because it's less buggy
;; (setq help-window-select t)

;; Just automatically always select new buffers
;; This works better than below `defadvice display-buffer' method with `magit',
;; otherwise seems identical
;; This makes `next-error' to cycle through grep matches always open in a new
;; window
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
;; (defadvice display-buffer (after rk/display-buffer-select (buffer &optional action frame) activate)
;;   "Wrapper function description."
;;   (if buffer
;;       (let (
;;             (window (get-buffer-window buffer))
;;             )
;;         (if (window-live-p window)
;;             (select-window window)
;;           )
;;         )
;;     )
;;   )

;; Don't show tab bar for one tab
;; This causes the echo area to disappear when a new frame is added
;; (if window-system
;;     (setq tab-bar-show nil)
;;   (setq tab-bar-show 1)
;;   )
;; Show for more than 1 tab
;; (setq tab-bar-show 1)
;; Always show
(setq tab-bar-show t)
;; Never show
;; (setq tab-bar-show nil)
;; Don't show close button
(setq tab-bar-close-button-show nil)
;; Hide plus button and other extras
;; (setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator))
(setq tab-bar-format '(tab-bar-format-tabs))
;; Hide ugly bar separator in terminal emacs
;; (setq tab-bar-separator " ")
(setq tab-bar-separator "")
;; Turn on tab bar (must be after setting options)
(tab-bar-mode)
;; Show numbers
(setq tab-bar-tab-hints t)
;; Allow selecting tabs with `M-#'
;; Not sure why this doesn't work
;; (setq tab-bar-select-tab-modifiers '(meta))
;; Add space to sides of `tab-bar'
;; Don't make ugly massive tabs
(setq tab-bar-auto-width nil)
(defun rk/tab-bar-tab-name-format (tab i)
  (let ((current-p (eq (car tab) 'current-tab)))
    (propertize
     (concat
      " "
      (if tab-bar-tab-hints (format "%d " i) "")
      ;; (alist-get 'name tab)
      ;; (or (and tab-bar-close-button-show
      ;;          (not (eq tab-bar-close-button-show
      ;;                   (if current-p 'non-selected 'selected)))
      ;;          tab-bar-close-button)
      ;;     "")
      ;; " "
      )
     'face (funcall tab-bar-tab-face-function tab))))
(setq tab-bar-tab-name-format-function 'rk/tab-bar-tab-name-format)

(provide 'robenkleene-window-management)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-window-management.el ends here
