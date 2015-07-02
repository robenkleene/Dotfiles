;;; robenkleene-magit.el --- robenkleene-magit
;;; Commentary:
;;; Code:


;; This evil jumper strategy doesn't work because `evil-jumper' provides both push and pop logic
;; specific to the "*scratch*" buffer. In order to support this, really `evil-jumper' will need to be
;; refactored
;; (defun robenkleene/magit-evil-jumper-push ()
;;   "Pushes the current cursor/file position to the jump list."
;;   (let ((target-list (evil-jumper--get-window-jump-list)))
;;     (while (> (length target-list) evil-jumper-max-length)
;;       (nbutlast target-list 1))
;;     (let ((file-name (buffer-name))
;;           (buffer-name (buffer-name))
;;           (current-pos (point))
;;           (first-pos nil)
;;           (first-file-name nil)
;;           (excluded nil))
;;       (when file-name
;;         (dolist (pattern evil-jumper-ignored-file-patterns)
;;           (when (string-match-p pattern file-name)
;;             (setq excluded t)))
;;         (unless excluded
;;           (when target-list
;;             (setq first-pos (caar target-list))
;;             (setq first-file-name (car (cdar target-list))))
;;           (unless (and (equal first-pos current-pos)
;;                        (equal first-file-name file-name))
;;             (push `(,current-pos ,file-name) target-list)))))
;;     (evil-jumper--message "%s %s" (selected-window) (car target-list))
;;     (evil-jumper--set-window-jump-list target-list)))

(eval-after-load 'magit
  '(progn
     (defvar magit-status-buffer-switch-function)
     (setq magit-status-buffer-switch-function 'switch-to-buffer)
     ;; (defadvice magit-visit-item (before magit-visit-item activate)
     ;;   ;; (evil-jumper--push)
     ;;   (robenkleene/magit-evil-jumper-push)
     ;;   )
     )
  )

(provide 'robenkleene-magit)
;;; robenkleene-magit.el ends here
