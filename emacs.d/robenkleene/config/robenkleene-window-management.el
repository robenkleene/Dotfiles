;;; robenkleene-window-management.el --- robenkleene-window-management
;;; Commentary:
;;; Code:

;; Don't show tab bar for one tab
;; This causes the echo area to disappear when a new frame is added
;; (if window-system
;;     (setq tab-bar-show nil)
;;   (setq tab-bar-show 1)
;;   )
;; Show for more than 1 tab
(setq tab-bar-show 1)
;; Always show
;; (setq tab-bar-show t)
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
      (alist-get 'name tab)
      (or (and tab-bar-close-button-show
               (not (eq tab-bar-close-button-show
                        (if current-p 'non-selected 'selected)))
               tab-bar-close-button)
          "")
      " "
      )
     'face (funcall tab-bar-tab-face-function tab))))
(setq tab-bar-tab-name-format-function 'rk/tab-bar-tab-name-format)

;; Forcing Focus
;; Not doing this because too many windows aren't automatically focused, e.g.,
;; I'd also have to add `grep' buffers

;; (setq Man-notify-method 'aggressive)
;; (setq help-window-select t)
;; Everywhere
;; This causes problems where sometimes focus isn't wanted, e.g., Magit commit
;; creates a diff of the changes and this will focus that diff
;; (defun rk/display-buffer-focus (orig-fun buffer &rest args)
;;   "Wrap `display-buffer` to select the window it displays."
;;   (let ((window (apply orig-fun buffer args)))
;;     (when window
;;       (select-window window))
;;     window))
;; (advice-add 'display-buffer :around #'rk/display-buffer-focus)

;; Focus buffers for custom `egit' commands
;; (add-to-list
;;  'display-buffer-alist
;;  '("\\*egit\\*" . (nil . ((body-function . select-window)))))

;; ;; Focus buffers for `shell-command'
;; (add-to-list
;;  'display-buffer-alist
;;  '("\\*Async Shell Command\\*" . (nil . ((body-function . select-window)))))
;; (add-to-list
;;  'display-buffer-alist
;;  '("\\*Shell Command Output\\*" . (nil . ((body-function . select-window)))))

(provide 'robenkleene-window-management)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-window-management.el ends here
